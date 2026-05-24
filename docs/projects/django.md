# Django (Python) project setup

Python web projects using Django on your Ubuntu stack (Python 3.12, PostgreSQL/SQLite, optional Redis).

---

## Prerequisites (system-wide)

```bash
sudo apt install python3 python3-pip python3-venv python3-django \
  postgresql libpq-dev
# Or after setup.sh which includes python3-django
python3 --version
```

---

## 1. Project location

```bash
mkdir -p ~/src/github/johnboscocjt
cd ~/src/github/johnboscocjt
```

---

## 2. New Django project

```bash
python3 -m venv venv
source venv/bin/activate

pip install django psycopg2-binary python-dotenv

django-admin startproject myproject .
python manage.py startapp myapp
```

### Clone existing repo

```bash
git clone https://github.com/johnboscocjt/my-django-app.git
cd my-django-app
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
```

---

## 3. Database setup

### SQLite (development default)

`settings.py` — already works out of the box:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}
```

### PostgreSQL

```bash
sudo -u postgres createdb myproject
sudo -u postgres psql -c "CREATE USER django WITH PASSWORD 'your_password';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE myproject TO django;"
```

`.env`:

```env
DB_ENGINE=django.db.backends.postgresql
DB_NAME=myproject
DB_USER=django
DB_PASSWORD=your_password
DB_HOST=127.0.0.1
DB_PORT=5432
SECRET_KEY=your-secret-key-here
DEBUG=True
```

`settings.py` (use python-dotenv):

```python
import os
from dotenv import load_dotenv
load_dotenv()

DATABASES = {
    'default': {
        'ENGINE': os.getenv('DB_ENGINE', 'django.db.backends.sqlite3'),
        'NAME': os.getenv('DB_NAME', BASE_DIR / 'db.sqlite3'),
        'USER': os.getenv('DB_USER', ''),
        'PASSWORD': os.getenv('DB_PASSWORD', ''),
        'HOST': os.getenv('DB_HOST', ''),
        'PORT': os.getenv('DB_PORT', ''),
    }
}
SECRET_KEY = os.getenv('SECRET_KEY')
DEBUG = os.getenv('DEBUG', 'False') == 'True'
```

---

## 4. Migrate and run

```bash
source venv/bin/activate
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver
# → http://127.0.0.1:8000
```

Admin panel: `http://127.0.0.1:8000/admin/`

---

## 5. Static files (production)

```bash
python manage.py collectstatic
```

For development, `runserver` serves static files when `DEBUG=True`.

---

## 6. IDE setup

```bash
cursor .
```

Install Python extension if not present: `ms-python.python`

Select interpreter: `venv/bin/python`

---

## 7. `.gitignore` essentials

```
venv/
__pycache__/
*.pyc
.env
db.sqlite3
staticfiles/
media/
```

Commit `requirements.txt`:

```bash
pip freeze > requirements.txt
```

---

## Quick reference

```bash
git clone <repo>
cd <repo>
python3 -m venv venv && source venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
python manage.py migrate
python manage.py runserver
```

See also: [Laravel setup](laravel.md) · [Node setup](node-javascript.md)
