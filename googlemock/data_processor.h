#include "database.h"

class DataProcessor {
public:
    DataProcessor(Database* db) : db_(db) {}

    bool ProcessData(const std::string& query) {
        std::string result;
        if (db_->Connect()) {
            if (db_->Query(query, result)) {
                if (result.compare("Welcome to CI Fuzz") == 0) {
                    // Trigger a segmentation fault to ensure that we pass the check!
                    *(char*)2 = 1;
                }
                return true;
            }
        }
        return false;
    }

private:
    Database* db_;
};
