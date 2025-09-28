package com.api.automation.mocks;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.api.TestInstance.Lifecycle;
import org.mockserver.client.MockServerClient;
import org.mockserver.model.HttpRequest;
import org.mockserver.model.HttpResponse;
import org.mockserver.model.MediaType;
import org.mockserver.model.Parameter;
import org.mockserver.netty.MockServer;

import com.intuit.karate.Results;
import com.intuit.karate.Runner.Builder;

@TestInstance(Lifecycle.PER_CLASS)
public class ProductCompositeServiceParallelRunner {

	// 1. Create a setup method -> contains @BeforeAll ->start the mock server and
	// mock client
	// 2. Create a teardown method -> @AfterAll --> shutdown the mock server and
	// client
	// 3. Create a test method -> @Test(junit) --> parallel runner to run the
	// feature file
	// 4. MockProductService -> Intercept the request going to product service and
	// respond with mock response
	// 5. MockReviewService -> Intercept the request going to review service and
	// respond with mock response

	private MockServer server;
	private MockServerClient client;

	@BeforeAll
	public void setup() {
		server = new MockServer(9092);
		client = new MockServerClient("localhost", server.getLocalPort());
	}

	@AfterAll
	public void teardown() {
		if (server.isRunning())
			server.stop();
		if (!client.hasStopped())
			client.stop();
	}

	@Test
	public void runTest() {
		mockProductService();
		mockReviewService();
		Builder builder = new Builder();
		builder.path("classpath:com/api/automation/mocks/productCompositeServiceTest.feature");
		Results result = builder.parallel(1);
		Assertions.assertEquals(0, result.getFailCount());
	}

	private void mockProductService() {
		String body = "{\r\n" + "    \"name\": \"name-123\",\r\n" + "    \"weight\": 123,\r\n"
				+ "    \"productID\": 123\r\n" + "}";
		// http://localhost:9092/product/123
		HttpRequest requestIntecept = HttpRequest.request("/product/{productId}")
				.withPathParameters(Parameter.param("productId", "123"));
		HttpResponse mockResponse = HttpResponse.response(body).withContentType(MediaType.APPLICATION_JSON);
		client.when(requestIntecept).respond(mockResponse);
	}

	private void mockReviewService() {
		String body = "[\r\n" + "    {\r\n" + "        \"productId\": 123,\r\n" + "        \"reviewId\": 456,\r\n"
				+ "        \"author\": \"John\",\r\n" + "        \"subject\": \"Good\",\r\n"
				+ "        \"content\": \"This is a good product\"\r\n" + "    },\r\n" + "    {\r\n"
				+ "        \"productId\": 123,\r\n" + "        \"reviewId\": 741,\r\n"
				+ "        \"author\": \"Todd\",\r\n" + "        \"subject\": \"Very Good\",\r\n"
				+ "        \"content\": \"This is a fantastic product\"\r\n" + "    }\r\n" + "]";
		// http://localhost:9091/review/123
		HttpRequest requestIntecept = HttpRequest.request("/review/{productId}")
				.withPathParameters(Parameter.param("productId", "123"));
		HttpResponse mockResponse = HttpResponse.response(body).withContentType(MediaType.APPLICATION_JSON);
		client.when(requestIntecept).respond(mockResponse);
	}
}
