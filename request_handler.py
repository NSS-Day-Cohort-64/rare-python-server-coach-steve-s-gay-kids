import json
from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import urlparse, parse_qs
from views.user import create_user, login_user
from views.tags_request import get_all_tags, get_single_tag, create_tag, delete_tag, update_tag
from views.posts_requests import get_all_posts, get_single_post


class HandleRequests(BaseHTTPRequestHandler):
    """Handles the requests to this server"""

    def parse_url(self, path):
        path_params = path.split('/')
        resource = path_params[1]
        id = None
        if '?' in resource:
            resource = resource.split('?')[0]
            param = resource.split('?')[1]
            pair = param.split('=')
            key = pair[0]
            value = pair[1]
            return (resource, key, value)
        else:
            try:
                id = int(path_params[2])
            except (IndexError, ValueError):
                pass
        return (resource, id)

    def _set_headers(self, status):
        """Sets the status code, Content-Type and Access-Control-Allow-Origin
        headers on the response

        Args:
            status (number): the status code to return to the front end
        """
        self.send_response(status)
        self.send_header('Content-type', 'application/json')
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()

    def do_OPTIONS(self):
        """Sets the OPTIONS headers"""
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE')
        self.send_header('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept')
        self.end_headers()

    def do_GET(self):

        self._set_headers(200)
        response = {}

        (resource, id) = self.parse_url(self.path)
        if resource == "tags":
            if id is not None:
                response = get_single_tag(id)
                success = True
            else:
                response = get_all_tags()
                success = True
        if success:
            self._set_headers(200)
        else:
            self._set_headers(404)
            
        if resource == "posts":
            if id is not None:
                response = get_single_post(id)

            else:
                response = get_all_posts()

        if resource == "users":
            if id is not None:
                # Assuming the user is authenticated, retrieve user data by ID
                # This may involve querying the database for user information
                # You need to implement this function
                user_data = login_user(id)
            if user_data is not None:
                response = user_data
            else:
                response = {'error': 'User not found'}

        # Convert the response to a JSON string and send it as the response body

        self.wfile.write(json.dumps(response).encode())

    def do_POST(self):
        """Make a POST request to the server"""
        content_len = int(self.headers.get('content-length', 0))
        post_body = json.loads(self.rfile.read(content_len).decode())

        resource = self.parse_url()[0]  # Access the 'resource' from the 'parse_url' method
        response = ""

        if resource == 'login':
            response = login_user(post_body)
        if resource == 'register':
            response = create_user(post_body)
        if resource == 'tags':
            response = create_tag(post_body)

        self._set_headers(201)
        self.wfile.write(json.dumps(response).encode())

    def do_PUT(self):
        content_len = int(self.headers.get('content-length', 0))
        post_body = self.rfile.read(content_len)
        post_body = json.loads(post_body)

        resource, id = self.parse_url()  # Assign the result of 'self.parse_url()' to 'resource' and 'id'

        success = False
        error = ""

        if resource == "tags":
            success = update_tag(id, post_body)

        if success:
            self._set_headers(204)
        else:
            self._set_headers(404)
            self.wfile.write(json.dumps(error).encode())

    def do_DELETE(self):
        resource, id = self.parse_url()

        success = False

        if resource == "tags":
            success = delete_tag(id)

        if success:
            self._set_headers(204)
        else:
            self._set_headers(404)
            response = ""

            self.wfile.write(json.dumps(response).encode())


def main():
    """Starts the server on port 8088 using the HandleRequests class"""
    host = ''
    port = 8088
    HTTPServer((host, port), HandleRequests).serve_forever()


if __name__ == "__main__":
    main()
