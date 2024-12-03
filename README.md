# URL Shortener Service

A simple URL shortening service built with Ruby on Rails. This service allows users to shorten long URLs, retrieve the original URLs, and interact with an API for programmatic URL shortening.

## Features

- Shorten a URL via a web form.
- Redirect to the original URL when visiting the shortened URL.
- Expose an API for external clients to shorten URLs with token-based authentication.
- Swagger documentation for API.

## Setup and Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/Kanika170/url-shortner.git
    ```

2. **Navigate into the project directory**:
    ```bash
    cd url-shortner
    ```

3. **Install dependencies**:
    ```bash
    bundle install
    ```

4. **Set up the database**:
    ```bash
    rails db:create
    rails db:migrate
    ```

5. **Start the Rails server**:
    ```bash
    rails server
    ```

   The application will be available at `http://localhost:3000`.

## API Endpoints

### 1. Create Short URL (API)

- **URL**: `/api/urls`
- **Method**: `POST`
- **Request**:
  - `original_url` (string): The long URL to be shortened.
  - `token` (string): API token for authentication (passed in the Authorization header).

- **Response**:
  - `short_url` (string): The generated shortened URL.

**Example Request**:

```json
{
  "original_url": "https://example.com"
}
```

### 2. Redirect to Original URL (via Shortened URL)
- **URL**: `/api/urls/:short_url`
- **Method**: `GET`
- **Response**: Redirects to the original long URL.

---

### 3. Generate Short URL from Web Interface
Users can generate short URLs via the web form by navigating to:

```bash
http://localhost:3000/urls/new
```

### 4. Swagger Documentation
The API is documented using Swagger. To view the Swagger UI, go to:
```bash
http://localhost:3000/swagger
```
---

### Postman Collection
You can import the Postman collection for testing the API. Download the collection from this link and import it into Postman.
```bash
https://api.postman.com/collections/27820147-3a1cc1aa-e972-46e6-9ae4-9aa256d75ee6?access_key=PMAT-01JE5YJMABWRQKT5VQ5NKRB2CY
```
---

### Running Tests
The application uses RSpec for testing. To run the test suite, use the following command:

```bash
bundle exec rspec
```
