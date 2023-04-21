package com;

import app.User;
import app.UserRepository;

import app.UserService;
import com.code_intelligence.jazzer.api.FuzzedDataProvider;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import org.mockito.Mockito;
import org.springframework.data.mongodb.core.MongoTemplate;

import java.util.Optional;

public class UserServiceFuzzer {
    private static UserRepository userRepository;
    public static MongoTemplate mongoTemplate;

    public static void fuzzerInitialize() {
        MongoClient mongoClientMock = Mockito.mock(MongoClient.class);
        MongoDatabase mongoDatabaseMock = Mockito.mock(MongoDatabase.class);

        Mockito.when(mongoClientMock.getDatabase("fuzz")).thenReturn(mongoDatabaseMock);
        userRepository = Mockito.mock(UserRepository.class);
    }

    public static void fuzzerTestOneInput(FuzzedDataProvider data) {
        UserService userService = new UserService(userRepository);

        User user = new User(data.consumeString(50));
        Mockito.when(userRepository.findById(Mockito.any())).thenReturn(Optional.of(user));

        try {
            userService.validateEmail(user.id, data.consumeString(50));
        } catch (Exception e) {}
    }
}
