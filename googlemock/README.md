# Fuzzing with Google Mocks
This is an example of using Google Mocks in a fuzz test. 
The example consists of a `DataProcessor` class that is used to process
data fetched from a database. It uses a `DataBase` class to handle 
the actual database access, including connecting to the database and performing queries.
After fetching data from the database, it performs checks on it and returns a boolean value.

In our example, we deliberately trigger a segmentation fault if the query result is `"Welcome to CI Fuzz"` 
to ensure that the fuzzer can actually find this string. Typically, we don't want 
to have an actual database interaction during testing as this is slow and difficult to set up. To this end, we use Google Mock to mock the two methods provided by the `Database` class so that the `Query` method returns a fuzzer-generated string. This way, we can test our data processing logic efficiently.  

You can run the fuzz test as follows:
```bash
cifuzz run data_processor_fuzzer
```