kubectl exec -it db-app-0 -- sh
    mysql -u root -p
    use mydb;
    show tables;
    CREATE TABLE users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100),
        email VARCHAR(150)
    );
    INSERT INTO users (name, email)
    VALUES
        ('Akshat', 'akshat@example.com'),
        ('Rahul', 'rahul@example.com'),
        ('Priya', 'priya@example.com');
    SELECT * FROM users;
