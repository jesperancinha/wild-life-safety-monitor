plugins {
    kotlin("jvm") version "1.9.23"
    `java-library`
}

group = "org.jesperancinha.wlsm.messenger"
version = "unspecified"

repositories {
    mavenCentral()
}

dependencies {
    testImplementation("org.jetbrains.kotlin:kotlin-test")
}

tasks.test {
    useJUnitPlatform()
}
kotlin {
    jvmToolchain(21)
}

java {
    sourceSets.getByName("main").resources.srcDir("src/main/proto")
}
