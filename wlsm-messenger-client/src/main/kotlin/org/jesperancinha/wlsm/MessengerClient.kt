package org.jesperancinha.wlsm

import io.grpc.ManagedChannel
import io.grpc.ManagedChannelBuilder
import org.jesperancinha.wlsm.messenger.MessengerGrpcKt.MessengerCoroutineStub
import org.jesperancinha.wlsm.messenger.message
import java.io.Closeable
import java.util.concurrent.TimeUnit

class MessengerClient(private val channel: ManagedChannel) : Closeable {
    private val stub: MessengerCoroutineStub = MessengerCoroutineStub(channel)

    suspend fun sendMessage(text: String, author: String) {
        val request = message {
            this.text = text
            this.author = author
        }
        val response = stub.send(request)
        println("Received: ${response.result}")
    }

    override fun close() {
        channel.shutdown().awaitTermination(5, TimeUnit.SECONDS)
    }
}

suspend fun main(args: Array<String>) {
//    val port = System.getenv("PORT")?.toInt() ?: 50051
    val port = System.getenv("PORT")?.toInt() ?: 8000

    val channel = ManagedChannelBuilder.forAddress("localhost", port).usePlaintext().build()

    val client = MessengerClient(channel)

    client.sendMessage(
        text = "text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text ",
        author = "Joao"
    )
}
