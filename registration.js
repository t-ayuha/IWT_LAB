
function validateForm(event) {
    event.preventDefault(); // Prevent form submission
    
    const name = document.getElementById('name').value;
    const id = document.getElementById('id').value;
    const password = document.getElementById('password').value;
    const email = document.getElementById('email').value;
    const age = document.getElementById('age').value;
    const gender = document.querySelector('input[name="gender"]:checked');
    const address = document.getElementById('address').value;
    const branch = document.getElementById('branch').value;
    const skills = document.querySelectorAll('input[name="skills"]:checked');

    // Validate name (must be characters and max length 25)
    const namePattern = /^[A-Za-z\s]{1,25}$/;
    if (!namePattern.test(name)) {
        alert("Name must be up to 25 characters long and contain only letters.");
        document.getElementById('name').focus();
        return false;
    }

    // Validate email
    const emailPattern = /^\S+@\S+\.\S+$/;
    if (!emailPattern.test(email)) {
        alert("Please enter a valid email address.");
        document.getElementById('email').focus();
        return false;
    }

    // Validate age (between 18 and 23)
    const ageNum = Number(age);
    if (isNaN(ageNum) || ageNum < 18 || ageNum > 23) {
        alert("Age must be a number between 18 and 23.");
        document.getElementById('age').focus();
        return false;
    }

    // Validate technical skills (at least two options)
    if (skills.length < 2) {
        alert("Please select at least two technical skills.");
        return false;
    }

    // Check for empty fields
    if (!name || !id || !password || !email || !age || !gender || !address || !branch) {
        alert("All fields must be filled.");
        return false;
    }

    // If validation passes, display form data in a new window
    let newWindow = window.open("", "_blank");
    newWindow.document.write("<h1>Registration Details</h1>");
    newWindow.document.write(`<p>Name: ${name}</p>`);
    newWindow.document.write(`<p>ID: ${id}</p>`);
    newWindow.document.write(`<p>Password: ${password}</p>`);
    newWindow.document.write(`<p>Email: ${email}</p>`);
    newWindow.document.write(`<p>Age: ${age}</p>`);
    newWindow.document.write(`<p>Gender: ${gender.value}</p>`);
    newWindow.document.write(`<p>College Address: ${address}</p>`);
    newWindow.document.write(`<p>Branch: ${branch}</p>`);
    newWindow.document.write(`<p>Technical Skills: ${Array.from(skills).map(skill => skill.value).join(", ")}</p>`);
    return true;
}