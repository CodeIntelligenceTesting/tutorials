// Adapted and improved from:
//   <https://github.com/google/fuzzer-test-suite/blob/master/libpng-1.2.56/png_mutator.h>
#include <algorithm>
#include <array>
#include <cassert>
#include <cstdint>
#include <cstring>
#include <iostream>
#include <istream>
#include <ostream>
#include <random>
#include <sstream>
#include <string>
#include <vector>

#include <zlib.h>

class PngMutator {
  using ByteArray = std::vector<uint8_t>;

public:
  // The constructor reads a PNG file from the input stream,
  // decompresses the chunk data when needed, and stores
  // each chunk into its own vector. It also merges
  // the IDAT chunks into one vector.
  PngMutator(std::istream &in) {
    ihdr_.resize(13);
    Read4(in);
    Read4(in); // Skip the 8-byte magic value.
    // read IHDR.
    if (ReadInteger(in) != 13)
      return;
    if (Read4(in) != Type("IHDR"))
      return;
    // Read 13 values.
    in.read(reinterpret_cast<char *>(ihdr_.data()), ihdr_.size());

    Read4(in); // ignore CRC
    ssize_t idat_idx = -1;

    while (in) {
      uint32_t len = ReadInteger(in);
      uint32_t type = Read4(in);
      if (type == Type("IEND"))
        break; // do nothing
      char chunk_name[5];
      memcpy(chunk_name, &type, 4);
      chunk_name[4] = 0;
      if (len > (1 << 20))
        return;
      ByteArray barr(len);
      in.read(reinterpret_cast<char *>(barr.data()), len);
      Read4(in); // ignore CRC

      if (type == Type("IDAT")) {
        if (idat_idx != -1)
          Append(&chunks_[idat_idx].barr, barr);
        else {
          idat_idx = chunks_.size();
          chunks_.push_back({type, barr});
        }
      } else if (type == Type("iCCP")) {
        auto it = barr.begin();
        while (it < barr.end() && isprint(*it))
          it++;
        if (it < barr.end() && !*it)
          it++;
        if (it < barr.end() && !*it)
          it++;
        barr = ByteArray(it, barr.end());
        auto uncompressed = Uncompress(barr);
        chunks_.push_back({type, uncompressed});
        auto compressed = Compress(uncompressed);
      } else {
        chunks_.push_back({type, barr});
      }
    }
    if (idat_idx != -1)
      chunks_[idat_idx].barr = Uncompress(chunks_[idat_idx].barr);
  }

  // Serialize writes the modified PNG file to the output stream.
  void Serialize(std::ostream &out) {
    static constexpr std::array<unsigned char, 8> header = {
        0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a};
    out.write(reinterpret_cast<const char *>(header.data()), header.size());
    WriteChunk(out, "IHDR", ihdr_);
    for (auto &ch : chunks_) {
      if (ch.type == Type("iCCP")) {
        ByteArray barr;
        barr.push_back('x'); // assuming the iCCP name doesn't matter.
        barr.push_back(0);
        barr.push_back(0);
        auto compressed = Compress(ch.barr);
        Append(&barr, compressed);
        WriteChunk(out, ch.type, barr);
      } else {
        WriteChunk(out, ch.type, ch.barr);
      }
    }
    WriteChunk(out, "IEND", {});
  }

  // MutateIHDR modifies the IHDR chunk by randomly changing
  // one of the following properties: bit depth, color type,
  // or compression method.
  void MutateIHDR(ByteArray &ihdr) {
    if (ihdr.size() < 13)
      return; // IHDR must be 13 bytes long

    std::minstd_rand rnd(time(0));
    int choice = rnd() % 3;
    switch (choice) {
    case 0: // Modify bit depth
      ihdr[8] = (ihdr[8] + (rnd() % 8) + 1) % 16;
      break;
    case 1: // Modify color type
      ihdr[9] = (ihdr[9] + (rnd() % 7)) % 8;
      break;
    case 2: // Modify compression method
      ihdr[10] = (ihdr[10] + (rnd() % 2)) % 2;
      break;
    }
    if ((rnd() % 3) == 0) {
      MutateWidthHeight(ihdr);
    }
  }

  // MutatePLTE randomly changes, adds, or removes a palette
  // entry in the PLTE chunk.
  void MutatePLTE(ByteArray &plte) {
    std::minstd_rand rnd(time(0));

    // Randomly change, add or remove palette entries
    int choice = rnd() % 3;
    switch (choice) {
    case 0: // Change a random palette entry
      if (!plte.empty()) {
        size_t index = (rnd() % (plte.size() / 3)) * 3;
        plte[index] = rnd() % 256;
        plte[index + 1] = rnd() % 256;
        plte[index + 2] = rnd() % 256;
      }
      break;
    case 1:                    // Add a random palette entry
      if (plte.size() < 768) { // Maximum 256 palette entries (256 * 3)
        plte.push_back(rnd() % 256);
        plte.push_back(rnd() % 256);
        plte.push_back(rnd() % 256);
      }
      break;
    case 2: // Remove a random palette entry
      if (plte.size() >= 3) {
        size_t index = (rnd() % (plte.size() / 3)) * 3;
        plte.erase(plte.begin() + index, plte.begin() + index + 3);
      }
      break;
    }
  }

  // MutatetRNS randomly changes, adds, or removes a transparency
  // entry in the tRNS chunk.
  void MutatetRNS(ByteArray &trns) {
    std::minstd_rand rnd(time(0));

    // Randomly change, add or remove transparency entries
    int choice = rnd() % 3;
    switch (choice) {
    case 0: // Change a random transparency entry
      if (!trns.empty()) {
        size_t index = rnd() % trns.size();
        trns[index] = rnd() % 256;
      }
      break;
    case 1: // Add a random transparency entry
      trns.push_back(rnd() % 256);
      break;
    case 2: // Remove a random transparency entry
      if (!trns.empty()) {
        size_t index = rnd() % trns.size();
        trns.erase(trns.begin() + index);
      }
      break;
    }
  }

  // MutateWidthHeight modifies the width and height of the image
  // in the IHDR chunk.
  void MutateWidthHeight(ByteArray &ihdr) {
    std::minstd_rand rnd(time(0));
    uint32_t new_width = rnd() % 1024 + 1;
    uint32_t new_height = rnd() % 1024 + 1;
    ihdr[0] = (new_width >> 24) & 0xFF;
    ihdr[1] = (new_width >> 16) & 0xFF;
    ihdr[2] = (new_width >> 8) & 0xFF;
    ihdr[3] = new_width & 0xFF;
    ihdr[4] = (new_height >> 24) & 0xFF;
    ihdr[5] = (new_height >> 16) & 0xFF;
    ihdr[6] = (new_height >> 8) & 0xFF;
    ihdr[7] = new_height & 0xFF;
  }

  // The Mutator type is a function that takes a raw byte array
  // and mutates it, similar to libFuzzer's mutation function
  using Mutator = size_t (*)(uint8_t *Data, size_t Size, size_t MaxSize);

  // Mutate performs various mutations on the in-memory representation
  // of the PNG file. Given the same seed, the same mutation is performed.
  void Mutate(Mutator m, unsigned int Seed) {
    std::minstd_rand rnd(Seed);
    auto M = [&](ByteArray *barr) {
      if (barr->empty())
        barr->resize(barr->size() + 1 + rnd() % 256);
      barr->resize(m(barr->data(), barr->size(), barr->size()));
    };
    switch (rnd() % 9) {
    // Mutate IHDR.
    case 0:
      m(ihdr_.data(), ihdr_.size(), ihdr_.size());
      break;
    // Mutate some other chunk.
    case 1:
      if (!chunks_.empty())
        M(&chunks_[rnd() % chunks_.size()].barr);
      break;
    // Shuffle the chunks.
    case 2:
      std::shuffle(chunks_.begin(), chunks_.end(), rnd);
      break;
    // Delete a random chunk.
    case 3:
      if (!chunks_.empty())
        chunks_.erase(chunks_.begin() + rnd() % chunks_.size());
      break;
    // Insert a random chunk with one of the known types, or a random type.
    case 4: {
      static const char *types[] = {
          "IATx", "sTER", "hIST", "sPLT", "mkBF", "mkBS", "mkTS",
          "prVW", "oFFs", "iDOT", "zTXt", "mkBT", "acTL", "iTXt",
          "sBIT", "tIME", "iCCP", "vpAg", "tRNS", "cHRM", "PLTE",
          "bKGD", "gAMA", "sRGB", "pHYs", "fdAT", "fcTL", "tEXt",
          "IDAT", "pCAL", "sCAL", "eXIf", "fUZz", "aNcI"};
      static const size_t n_types = sizeof(types) / sizeof(types[0]);
      uint32_t type =
          (rnd() % 10 <= 8) ? Type(types[rnd() % n_types]) : (uint32_t)rnd();
      size_t len = rnd() % 256;
      if (type == Type("fUZz"))
        len = 16;
      ByteArray barr(len);
      for (auto &b : barr)
        b = rnd();
      size_t pos = rnd() % (chunks_.size() + 1);
      chunks_.insert(chunks_.begin() + pos, {type, barr});
    } break;
    // Any more interesting mutations with a PNG file?
    case 5: {
      auto it =
          std::find_if(chunks_.begin(), chunks_.end(),
                       [](const Chunk &ch) { return ch.type == Type("fUZz"); });
      if (it != chunks_.end())
        m(it->barr.data(), it->barr.size(), it->barr.size());
    } break;
    // Mutate IHDR chunk (bit depth, color type, compression method)
    case 6: {
      auto it =
          std::find_if(chunks_.begin(), chunks_.end(),
                       [](const Chunk &ch) { return ch.type == Type("IHDR"); });
      if (it != chunks_.end())
        MutateIHDR(it->barr);
    } break;
    // Mutate PLTE chunk
    case 7: {
      auto it =
          std::find_if(chunks_.begin(), chunks_.end(),
                       [](const Chunk &ch) { return ch.type == Type("PLTE"); });
      if (it != chunks_.end())
        MutatePLTE(it->barr);
    } break;
    // Mutate tRNS chunk
    case 8: {
      auto it =
          std::find_if(chunks_.begin(), chunks_.end(),
                       [](const Chunk &ch) { return ch.type == Type("tRNS"); });
      if (it != chunks_.end())
        MutatetRNS(it->barr);
    } break;
    }
  }

  // CrossOver takes a random chunk from another PngMutator
  // instance and inserts it into the current PngMutator instance.
  void CrossOver(const PngMutator &p, unsigned int Seed) {
    if (p.chunks_.empty())
      return;
    std::minstd_rand rnd(Seed);
    size_t idx = rnd() % p.chunks_.size();
    auto &ch = p.chunks_[idx];
    size_t pos = rnd() % (chunks_.size() + 1);
    chunks_.insert(chunks_.begin() + pos, ch);
  }

private:
  // Append concatenates two ByteArray objects.
  void Append(ByteArray *to, const ByteArray &from) {
    to->insert(to->end(), from.begin(), from.end());
  }

  // Read4 reads a 4-byte unsigned integer from the input stream.
  uint32_t Read4(std::istream &in) {
    uint32_t res = 0;
    in.read((char *)&res, sizeof(res));
    return res;
  }

  // ReadInteger reads a 4-byte unsigned integer from the input stream
  // and converts it to host byte order.
  uint32_t ReadInteger(std::istream &in) {
    return __builtin_bswap32(Read4(in));
  }

  // Type converts a 4-character string to a 4-byte unsigned integer.
  static uint32_t Type(const char *tagname) {
    uint32_t res;
    assert(strlen(tagname) == 4);
    memcpy(&res, tagname, 4);
    return res;
  }

  // WriteInt writes a 4-byte unsigned integer to the output stream
  // in network byte order.
  void WriteInt(std::ostream &out, uint32_t x) {
    x = __builtin_bswap32(x);
    out.write((char *)&x, sizeof(x));
  }

  // WriteChunk writes a chunk to the output stream.
  // It includes the 4-byte length, 4-byte type, data, and 4-byte CRC
  void WriteChunk(std::ostream &out, const char *type, const ByteArray &chunk,
                  bool compress = false) {
    ByteArray compressed;
    const ByteArray *barr = &chunk;
    if (compress) {
      compressed = Compress(chunk);
      barr = &compressed;
    }
    uint32_t len = barr->size();
    uint32_t crc = crc32(0, (const unsigned char *)type, 4);
    if (barr->size())
      crc = crc32(crc, (const unsigned char *)barr->data(), barr->size());
    WriteInt(out, len);
    out.write(type, 4);
    out.write((const char *)barr->data(), barr->size());
    WriteInt(out, crc);
  }

  void WriteChunk(std::ostream &out, uint32_t type, const ByteArray &chunk) {
    char type_s[5];
    memcpy(type_s, &type, 4);
    type_s[4] = 0;
    WriteChunk(out, type_s, chunk);
  }

  // Uncompress decompresses a ByteArray using the zlib library
  ByteArray Uncompress(const ByteArray &compressed) {
    ByteArray vbarr;
    static const size_t kMaxBuffer = 1 << 28;
    for (size_t sz = compressed.size() * 4; sz < kMaxBuffer; sz *= 2) {
      vbarr.resize(sz);
      unsigned long len = sz;
      auto res =
          uncompress(vbarr.data(), &len, compressed.data(), compressed.size());
      if (res == Z_BUF_ERROR)
        continue;
      if (res != Z_OK)
        return {};
      vbarr.resize(len);
      break;
    }
    return vbarr;
  }

  // Compress compresses a ByteArray using the zlib library
  ByteArray Compress(const ByteArray &uncompressed) {
    ByteArray barr;
    static const size_t kMaxBuffer = 1 << 28;
    for (size_t sz = uncompressed.size(); sz < kMaxBuffer; sz *= 2) {
      barr.resize(sz);
      unsigned long len = sz;
      auto res =
          compress(barr.data(), &len, uncompressed.data(), uncompressed.size());
      if (res == Z_BUF_ERROR)
        continue;
      if (res != Z_OK)
        return {};
      barr.resize(len);
      break;
    }
    return barr;
  }

  ByteArray ihdr_;

  struct Chunk {
    uint32_t type;
    ByteArray barr;
  };
  std::vector<Chunk> chunks_;
};

extern "C" size_t LLVMFuzzerMutate(uint8_t *Data, size_t Size, size_t MaxSize);

#if STANDALONE_TARGET
size_t LLVMFuzzerMutate(uint8_t *Data, size_t Size, size_t MaxSize) {
  assert(false &&
         "LLVMFuzzerMutate should not be called from StandaloneFuzzTargetMain");
  return 0;
}
#endif

extern "C" size_t LLVMFuzzerCustomMutator(uint8_t *Data, size_t Size,
                                          size_t MaxSize, unsigned int Seed) {
  std::string s(reinterpret_cast<const char *>(Data), Size);
  std::stringstream in(s);
  std::stringstream out;
  PngMutator PCM(in);
  PCM.Mutate(LLVMFuzzerMutate, Seed);
  PCM.Serialize(out);
  const auto &str = out.str();
  if (str.size() > MaxSize)
    return Size;
  memcpy(Data, str.data(), str.size());
  return str.size();
}

extern "C" size_t LLVMFuzzerCustomCrossOver(const uint8_t *Data1, size_t Size1,
                                            const uint8_t *Data2, size_t Size2,
                                            uint8_t *Out, size_t MaxOutSize,
                                            unsigned int Seed) {
  std::stringstream in1(
      std::string(reinterpret_cast<const char *>(Data1), Size1));
  std::stringstream in2(
      std::string(reinterpret_cast<const char *>(Data2), Size2));
  PngMutator PCM1(in1);
  PngMutator PCM2(in2);
  PCM1.CrossOver(PCM2, Seed);
  std::stringstream out;
  PCM1.Serialize(out);
  const auto &str = out.str();
  if (str.size() > MaxOutSize)
    return 0;
  memcpy(Out, str.data(), str.size());
  return str.size();
}
