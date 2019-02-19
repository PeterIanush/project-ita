provider "google" {
credentials = "${file("./cred/con.json")}"
project = "ita-project-232217"
region = "us-central1"
}
