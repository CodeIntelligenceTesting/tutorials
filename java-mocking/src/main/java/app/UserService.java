package app;

import java.util.Optional;
import java.util.regex.Pattern;
public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
    public Boolean validateEmail(String id, String domainName) {
        Optional<User> user = userRepository.findById(id);
        if (user.isEmpty()) {
            throw new RuntimeException("User cannot be found");
        }

        Pattern pattern = Pattern.compile("\\w+@" + domainName);
        return pattern.matcher(user.get().email).matches();
    }
}