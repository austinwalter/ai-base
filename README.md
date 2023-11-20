## Setup

### How to initialize a Python project environment
- create new projectfolder
- cd into it
- create a git repo `git init`
- create a `.gitignore` and add folders/files you don't want to commit like `venv, output, __pycache__`
- create a `README.md` file
- create virtual environment `> python -m venv ".venv"`
- use terminal to start venv
	`> source .venv/bin/activate`
- `> pip install ...`
- after installing all packages create requirements.txt:
	`> pip freeze > requirements.txt`
- if you already have a requirements.txt skip installing manually by simply:
	`> python -m pip install -r requirements.txt`


### Creating Virtual Environments
```
python3 -m venv .venv
source .venv/bin/activate
```
https://docs.python.org/3/tutorial/venv.html
