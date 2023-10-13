#include "gmock/gmock.h"
#include "gtest/gtest.h"

#include "data_processor.h"
#include "database_mock.h"

#include <cifuzz/cifuzz.h>
#include <fuzzer/FuzzedDataProvider.h>

extern "C" int LLVMFuzzerInitialize(int *argc, char ***argv) {
    ::testing::InitGoogleMock(argc, *argv);
    return 0;
}

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size){

    FuzzedDataProvider fuzzed_data(data, size);
    std::string query_result = fuzzed_data.ConsumeRandomLengthString();

    MockDatabase mock_db;
    DataProcessor data_processor(&mock_db);

    // Mock the behavior for fuzzing
    EXPECT_CALL(mock_db, Connect()).WillRepeatedly(::testing::Return(true));
    EXPECT_CALL(mock_db, Query(::testing::_, ::testing::_))
        .WillRepeatedly(::testing::DoAll(
            ::testing::SetArgReferee<1>(query_result), 
            ::testing::Return(true)));

    data_processor.ProcessData("SELECT * FROM table");

    return 0;
}
