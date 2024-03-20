buildscript {
    repositories {
        mavenLocal()
        mavenCentral()
    }
}

plugins {
    id("jacoco")
    id("java")
    id( "org.jesperancinha.plugins.omni") version "0.3.1"
}

tasks.withType<Test> {
    useJUnitPlatform()
}
