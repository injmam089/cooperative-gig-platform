package com.sih.workerreg;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class WorkerRegistrationApplication {

    public static void main(String[] args) {
        SpringApplication.run(WorkerRegistrationApplication.class, args);
        System.out.println("\n=======================================================");
        System.out.println("🚀 SIH Worker Registration System started successfully!");
        System.out.println("🌐 Open Frontend:  http://localhost:8080");
        System.out.println("📡 REST API Base:  http://localhost:8080/api/workers");
        System.out.println("=======================================================\n");
    }
}
