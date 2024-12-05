FROM python:3.10.5

# Create and set the working directory inside the container
WORKDIR /usr/app

# Copy application code into the container
COPY . . 

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
# Command to start the application
CMD ["python3", "src/app.py"]
