provider "google" {
credentials = "${file("./cred/credentials.json")}"
project = "even-crossing-229014"
region = "us-central1"
}
