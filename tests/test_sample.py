from modules.example import some_method


def return_test(test_str: str):
    assert test_str == some_method()


def test_some_method():
    test_str = "Method working"
    return_test(test_str)
