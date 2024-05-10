buildscript {
    repositories {
        mavenLocal()
        mavenCentral()
    }
}

plugins {
    jacoco
    java
    alias(libs.plugins.jesperancinha.omni)
}

tasks.withType<Test> {
    useJUnitPlatform()
}
