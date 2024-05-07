package org.jesperancinha.wlsm

import io.grpc.Server
import io.grpc.ServerBuilder
import io.grpc.stub.StreamObserver
import org.jesperancinha.wlsm.messenger.MessengerGrpc
import org.jesperancinha.wlsm.messenger.MessengerOuterClass

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

    internal class MessengerService : MessengerGrpc.MessengerImplBase() {
        override fun send(
            request: MessengerOuterClass.Message?,
            responseObserver: StreamObserver<MessengerOuterClass.MessageResponse>?
        ) {
            super.send(request, responseObserver)
        }
    }
}

fun main() {
    val port = System.getenv("PORT")?.toInt() ?: 50051
    val server = MessengerServer(port)
    server.start()
    server.blockUntilShutdown()
}
