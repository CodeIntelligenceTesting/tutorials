#pragma once

#include <string>

class Database {
public:
    virtual bool Connect() = 0;
    virtual bool Query(const std::string& query, std::string& result) = 0;
};

