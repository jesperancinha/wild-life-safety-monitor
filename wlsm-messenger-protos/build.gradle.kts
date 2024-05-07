plugins {
    alias(libs.plugins.kotlin.jvm)
    `java-library`
}

group = "org.jesperancinha.wlsm.messenger"
version = "0.0.0"

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
