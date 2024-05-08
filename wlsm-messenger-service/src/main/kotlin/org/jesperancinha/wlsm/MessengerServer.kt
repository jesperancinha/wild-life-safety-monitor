package org.jesperancinha.wlsm

import io.grpc.Server
import io.grpc.ServerBuilder
import org.jesperancinha.wlsm.messenger.MessengerGrpcKt
import org.jesperancinha.wlsm.messenger.MessengerOuterClass
import org.jesperancinha.wlsm.messenger.messageResponse

class MessengerServer(private val port: Int) {
    val server: Server =
        ServerBuilder
            .forPort(port)
            .addService(MessengerService())
            .build()

    fun start() {
        server.start()
        println("Server started, listening on $port")
        Runtime.getRuntime().addShutdownHook(
            Thread {
                println("*** shutting down gRPC server since JVM is shutting down")
                this@MessengerServer.stop()
                println("*** server shut down")
            },
        )
    }

    private fun stop() {
        server.shutdown()
    }

    fun blockUntilShutdown() {
        server.awaitTermination()
    }

    internal class MessengerService : MessengerGrpcKt.MessengerCoroutineImplBase() {
        override suspend fun send(request: MessengerOuterClass.Message) = messageResponse {
            println(request)
            this.result = 0
        }
    }
}

fun main() {
    val port = System.getenv("PORT")?.toInt() ?: 50051
    val server = MessengerServer(port)
    server.start()
    server.blockUntilShutdown()
}
