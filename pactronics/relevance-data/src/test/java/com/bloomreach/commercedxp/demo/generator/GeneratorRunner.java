package com.bloomreach.commercedxp.demo.generator;

import org.junit.Test;

import com.onehippo.cms7.targeting.demo.generator.DataGenerator;

public class GeneratorRunner {
    @Test
    public void runDataGenerator() throws Exception {
        final DataGenerator generator = new DataGenerator();
        generator.setSimulatedDays(1);
        generator.setSpeedup(350);
        generator.setGlobalRate(100);
        generator.setDefaultStoreLocation("sql=jdbc:mysql://localhost:3306/pactronics-generator?user=bloomreach,password=bloomreach");
        generator.setVisitsStoreLocation("elastic=http://localhost:9200,index=visits");
        generator.run();
    }
}
