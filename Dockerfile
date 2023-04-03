# Use the official Python image as the base image
FROM python:3.11

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Create and set the working directory
WORKDIR /app

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 - && \
      ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Copy the pyproject.toml file and install dependencies
COPY pyproject.toml .
RUN poetry config virtualenvs.create false && \
      poetry install --no-dev

# Copy the entire project
COPY . .

# Expose the port the app will run on
EXPOSE 8000

# Start the app
CMD ["poetry", "run", "python3", "manage.py", "runserver", "0.0.0.0:8000"]
