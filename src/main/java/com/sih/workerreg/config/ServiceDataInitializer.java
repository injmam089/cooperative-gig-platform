package com.sih.workerreg.config;

import com.sih.workerreg.model.ServiceItem;
import com.sih.workerreg.repository.ServiceRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Component
public class ServiceDataInitializer implements CommandLineRunner {

    private final ServiceRepository serviceRepository;

    public ServiceDataInitializer(ServiceRepository serviceRepository) {
        this.serviceRepository = serviceRepository;
    }

    @Override
    public void run(String... args) {
        // Automatically populate services table in MySQL if empty
        if (serviceRepository.count() == 0) {
            List<ServiceItem> initialServices = Arrays.asList(
                new ServiceItem("Plumbing", "Pipe repair, leakage fixing, tap and fitting work by certified plumbers.", "🔧"),
                new ServiceItem("AC Repair & Maintenance", "AC servicing, installation, component repair, and gas checking.", "❄️"),
                new ServiceItem("Cooking Services", "Nutritious home cooking, customized meal preparation, and event cooking.", "🍳"),
                new ServiceItem("Driver", "Professional personal drivers for local transit, daily commute, and outstation trips.", "🚗"),
                new ServiceItem("Electrical Services", "Complete wiring, switch/socket repair, and home electrical installations.", "⚡"),
                new ServiceItem("Cleaning Services", "Deep home cleaning, kitchen sanitization, bathroom scrubbing, and floor care.", "🧹"),
                new ServiceItem("Carpenter", "Custom woodwork, furniture repair, installation, and wooden fixture fixes.", "🪚"),
                new ServiceItem("Painting", "Interior room painting, complete house painting, texture design, and wall repair.", "🎨"),
                new ServiceItem("Mason / Construction", "Skilled masonry, brickwork, plastering, wall renovation, and minor construction.", "🧱"),
                new ServiceItem("Laundry", "Washing, fabric care, steam ironing, and routine laundry assistance.", "🧺")
            );

            serviceRepository.saveAll(initialServices);
            System.out.println("✅ Initialized 10 default services into MySQL 'services' table.");
        }
    }
}
