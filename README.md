# 🛍️ SimpleShop

A simple, affordable inventory and sales tracking tool for small, family-run shops.

---

## 📖 About the Project

Many small, family-run shops track sales and inventory by hand using pen and paper. Most commercial inventory software is either too expensive or too complex for their needs.  
**SimpleShop** solves this by providing an intuitive, low-cost tool that lets shop owners:  

- Add and manage inventory items  
- Record sales and automatically update stock  
- Get alerts when items are running low  
- View sales history and basic reports  

---

## 🛠️ Tech Stack

- Ruby on Rails 8 – Backend & Frontend  
- PostgreSQL / Xata – Database  
- Render – Hosting & Deployment  
- Devise – Authentication  
- RSpec & Capybara – Testing  

---

## 🚀 Setup & Installation

### Prerequisites

- Ruby 3.x and Rails 8  
- PostgreSQL (or Xata account if using hosted DB)  
- Node.js & Yarn  
- Bundler installed  

### Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/simpleshop.git
   cd simpleshop
   ```

2. Install dependencies:

    ```bash
    bundle install
    yarn install
    ```

3. Set up environment variables:

    ```env
    SECRET_KEY_BASE=your-secret
    DATABASE_URL=postgres://user:password@localhost/simpleshop_development
    XATA_API_KEY=your-xata-api-key

    ```

4. Set up the database:

    ```bash
    rails db:setup
    ```

5. Run the development server:

    ```bash
    bin/server
    ```

## ⚙️ Configuration

Database is configured via `config/database.yml`.

In production, `render.yaml` manages deployment with environment variables for:

- `SECRET_KEY_BASE` (auto-generated on Render)  
- `DATABASE_URL` (provided by Render or Xata)  
- `WEB_CONCURRENCY`  

---

## 🗂️ Entity Relationship Diagram (ERD)
![ERD](erd.png)
- **Business** has one **Owner** (`owner_id → Users.id`)  
- **Business** has many **Users** and **Items**  
- **User** belongs to a **Business** and records **Sales**  
- **Item** belongs to a **Business** and has many **Sales**  
- **Sale** belongs to a **User** and an **Item**  

---

## 📖 API Endpoints (Core)

Although primarily designed for web use, the app also supports JSON endpoints:

- `GET /items` → List all items  
- `POST /items` → Create a new item  
- `PUT /items/:id` → Update an item  
- `DELETE /items/:id` → Delete an item  
- `POST /sales` → Record a sale  
- `GET /sales` → View sales history  

Responses are in JSON. **Authentication is required** for all endpoints.  

---

## 🤝 Contributing

Contributions are welcome!

### Guidelines

- **Branch naming**:  
  - `feature/...` for new features  
  - `fix/...` for bug fixes  
  - `chore/...` for non-functional updates  
- **Code style**: Follow **Rubocop Rails Omakase**.  
- Write **RSpec tests** for new features.  
- Ensure migrations run cleanly before opening a PR.  

### Workflow

1. Fork the repo & create a feature branch.  

    ```bash
    git checkout -b feature/your-feature
    ```

2. Commit your changes and push.  
3. Open a Pull Request describing your changes.  

---

## ❓ Troubleshooting / FAQs
---

## ❓ Troubleshooting / FAQs

**Q: Rails asks for a master key.**  
A: Make sure `config/master.key` is present. If not, run `rails credentials:edit` and commit the generated key.  

**Q: Database won’t connect locally.**  
A: Check that `DATABASE_URL` in `.env` matches your local Postgres or Xata setup.  

**Q: Assets don’t load in production.**  
A: Run `rails assets:precompile` before deploying.  

---

## 👥 Author

Gladys Toledo-Rodriguez

---

## 📜 License

MIT License

Some rights reserved — see [LICENSE.txt](LICENSE.txt)
