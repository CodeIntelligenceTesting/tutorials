#pragma once

#include "gmock/gmock.h"
#include "database.h"

class MockDatabase : public Database {
public:
    MOCK_METHOD0(Connect, bool());
    MOCK_METHOD2(Query, bool(const std::string& query, std::string& result));
};