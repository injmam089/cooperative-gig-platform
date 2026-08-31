package com.sih.workerreg;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.BufferedReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@SpringBootApplication
public class WorkerRegistrationApplication {

    public static void main(String[] args) {
        loadDotEnvIfPresent();
        SpringApplication.run(WorkerRegistrationApplication.class, args);
        System.out.println("\n=======================================================");
        System.out.println("🚀 SIH Worker Registration System started successfully!");
        System.out.println("🌐 Open Frontend:  http://localhost:8088");
        System.out.println("📡 REST API Base:  http://localhost:8088/api/workers");
        System.out.println("=======================================================\n");
    }

    /**
     * Loads local environment variables from a root .env file if available,
     * allowing Brevo / SMTP secrets to be supplied securely without hardcoding.
     */
    private static void loadDotEnvIfPresent() {
        Path[] searchPaths = new Path[]{
                Paths.get(".env"),
                Paths.get(System.getProperty("user.dir", "."), ".env"),
                Paths.get(System.getProperty("user.home", "."), ".env")
        };

        for (Path envPath : searchPaths) {
            if (Files.exists(envPath) && Files.isRegularFile(envPath)) {
                try (BufferedReader reader = Files.newBufferedReader(envPath, StandardCharsets.UTF_8)) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        line = line.trim();
                        if (line.isEmpty() || line.startsWith("#")) continue;
                        int eq = line.indexOf('=');
                        if (eq > 0) {
                            String key = line.substring(0, eq).trim();
                            String val = line.substring(eq + 1).trim();
                            if ((val.startsWith("\"") && val.endsWith("\"")) || (val.startsWith("'") && val.endsWith("'"))) {
                                val = val.substring(1, val.length() - 1);
                            }
                            if (System.getProperty(key) == null && System.getenv(key) == null) {
                                System.setProperty(key, val);
                            }
                        }
                    }
                } catch (Exception ignored) {
                }
                break;
            }
        }
    }
}
