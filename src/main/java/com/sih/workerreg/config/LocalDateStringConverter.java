package com.sih.workerreg.config;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;
import java.time.LocalDate;

@Converter(autoApply = false)
public class LocalDateStringConverter implements AttributeConverter<LocalDate, String> {

    @Override
    public String convertToDatabaseColumn(LocalDate attribute) {
        return attribute != null ? attribute.toString() : LocalDate.now().toString();
    }

    @Override
    public LocalDate convertToEntityAttribute(String dbData) {
        if (dbData == null) {
            return LocalDate.now();
        }
        String str = dbData.trim();
        if (str.isEmpty()) {
            return LocalDate.now();
        }
        try {
            if (str.length() >= 10) {
                return LocalDate.parse(str.substring(0, 10));
            }
            return LocalDate.parse(str);
        } catch (Exception e) {
            String lower = str.toLowerCase();
            if (lower.contains("today")) return LocalDate.now();
            if (lower.contains("tomorrow")) return LocalDate.now().plusDays(1);
            return LocalDate.now();
        }
    }
}
