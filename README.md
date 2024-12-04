# Tester Tracker

## Description
Tester Tracker is an inventory management tool that allows Sephora team members to manage their store’s backstage product testers. It streamlines the process of managing backstage product testers, ensuring efficient tracking and organization.

### Disclaimer
**This application is not affiliated with, endorsed by, or officially connected to Sephora in any way.** It is solely a personal project developed as a playground environment for educational and experimental purposes. The app does not represent real employees, processes, or operations at Sephora. Any references to Sephora, its roles, or its products are purely fictional and for illustrative purposes only. 

    If you have any concerns regarding the use of brand names or references, feel free to reach out via the contact information below. 

## Features
- Role-specific views for Operations Associates, Admins, Beauty Advisors, Leads, and Managers, each with access to relevant features for their responsibilities.
- Search for products by name or SKU.
- Create and manage tester inventory.
- Trash and approve testers.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [Contact](#contact)

## Installation

1. Clone the repository:
`git clone https://github.com/dgarcia13-99/tester-tracker-sephora`

2. Navigate to the project directory:
`cd tester-tracker-sephora`

3. Install the required gems:
`bundle install`

4. Set up the database:
`rake sample_data`

5. Start the Rails server:
`bin/dev`

## Usage

1. Start the Rails server:
`bin/dev or dev`

2. Open browser and navigate to http://localhost:3000

3. Use one of the following user profiles to interact with data-rich views or create an account and interact with the application using data seeded into your role's interface. 

  NOTE: The credentials provided are for testing purposes only and do not correspond to any real Sephora accounts or information.

`username: 356177, password: password` : Operations interface
`username: 100000, password: password` : Admin interface
`username: 111111, password: password` : Beauty Advisor interface
`username: 222222, password: password` : Lead interface
`username: 333333, password: password` : Manager interface

4. The search functionality assumes user has knowledge of Sephora's products(e.g. product names or SKUs). Refer to the `Makeup`, `Skincare`, `Hair`, `Fragrance` views to find examples of product names or SKUs available at user's store location. 

5. Create a new tester in the `New` view. Use the products cards listed below the search bar to find a product you'd like to make a tester for.

Example of the `New` view for creating testers:
![alt text](tester-tracker-new-view-1.png)

6. `Manage Testers` and `Trash Tester` views are available only for Sephora's Operations Associates and Admin. If you'd like to access these views, sign up as an Operations Associate or Admin. 

7. As an Operations Associate, you can trash testers that have been placed onstage or aren't in condition to be an onstage tester.

8. An Operations Associate can remove newly created testers that have been placed onstage from inventory by approving them.

9. Admin and Operations teammembers can keep track of tester usage by visiting the `Trashed Testers` view.

## Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Open a pull request

## Contact

Daniela Garcia - [your email](mailto:danielagarcia13.99@gmail.com)
Project Link: [https://github.com/dgarcia13-99/tester-tracker-sephora](https://github.com/dgarcia13-99/tester-tracker-sephora)
