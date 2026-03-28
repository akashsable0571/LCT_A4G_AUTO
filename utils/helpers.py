import random
import string

class Helpers:

    @staticmethod
    def generate_random_string(length=6):
        return ''.join(random.choices(string.ascii_letters, k=length))
