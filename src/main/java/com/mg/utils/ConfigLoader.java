package com.mg.utils;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigLoader {

    public static String getServerIp(String configPath) {
        Properties props = new Properties();
        try (InputStream input = ConfigLoader.class.getClassLoader().getResourceAsStream("server.properties")) {
            if (input == null) {
                System.err.println("Fichier server.properties introuvable dans le classpath !");
                return null;
            }
            props.load(input);
            return props.getProperty("server.ip");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
