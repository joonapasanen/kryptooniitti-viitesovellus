class Reference:
    def __init__(self, id, cite_key, author, content):
        self.id = id
        self.cite_key = cite_key
        self.author = author
        self.content = content

    def __str__(self):
        return self.content
