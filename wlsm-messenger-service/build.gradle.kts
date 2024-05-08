plugins {
    alias(libs.plugins.kotlin.jvm)
    alias(libs.plugins.protobuf)
}

group = "org.jesperancinha.wlsm.messenger"
version = "0.0.0"

repositories {
    mavenCentral()
}

val gradleSysVersion = System.getenv("GRADLE_VERSION")

tasks.register<Wrapper>("wrapper") {
    gradleVersion =  gradleSysVersion
}

dependencies {
    protobuf(project(":wlsm-messenger-protos"))
    api(libs.grpc.protobuf)
    api(libs.grpc.kotlin.stub)
    api(libs.protobuf.kotlin)
    api(libs.grpc.stub)
    api(libs.protobuf.java.util)
    runtimeOnly(libs.grpc.netty)
    testImplementation("org.jetbrains.kotlin:kotlin-test")
}

tasks.test {
    useJUnitPlatform()
}
kotlin {
    jvmToolchain(21)
}

protobuf {
    protoc {
        artifact = libs.protoc.asProvider().get().toString()
    }
    plugins {
        create("grpc") {
            artifact = libs.protoc.gen.grpc.java.get().toString()
        }
        create("grpckt") {
            artifact = libs.protoc.gen.grpc.kotlin.get().toString() + ":jdk8@jar"
        }
    }
    generateProtoTasks {
        all().forEach {
            it.plugins {
                create("grpc")
                create("grpckt")
            }
            it.builtins {
                create("kotlin")
            }
        }
    }
}