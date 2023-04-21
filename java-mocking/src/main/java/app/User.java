package app;

import java.util.UUID;

public class User {
    public String id;
    public String email;

    public User(String email) {
        this.id = UUID.randomUUID().toString();
        this.email = email;
    }
}
