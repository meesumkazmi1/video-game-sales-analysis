# 🎮 Video Game Sales Analysis (SQL + Tableau)

## 📌 Project Overview
This project analyzes **global video game sales data (1980-2020)** using **SQL-based data modeling** and **Tableau visualization**. The dataset includes information on **game sales by platform, genre, publisher, and region**. The goal is to uncover key insights into **best-selling games, popular genres, publisher performance, regional trends, and platform dominance**.

🔹 **Key Features**:
- **SQL-based data normalization (3NF) & query analysis**
- **Insights on top-selling games, genres, platforms, and publishers**
- **Tableau Dashboard for interactive visualization**
- **Business recommendations based on findings**

🔗 **Live Tableau Dashboard**: [Click here to view](https://public.tableau.com/app/profile/syed.meesum.ali.kazmi/viz/VideoGamesSales_17396787904240/Dashboard1?publish=yes)

---

## 📌 Dataset
- **Source**: Kaggle / Public datasets (Sales data for games that sold **>100,000 copies**)
- **Time Range**: 1980 - 2020 (Focus: **1980-2016** due to fewer reported sales post-2016)
- **Data Fields**:
  - 🎮 `Name`: Game title
  - 🏆 `Genre`: Game category (Action, Shooter, Sports, etc.)
  - 🏢 `Publisher`: Company that released the game (Nintendo, EA, Activision, etc.)
  - 🎮 `Platform`: Console or PC platform (PS2, Xbox, Wii, etc.)
  - 📅 `Year`: Release year of the game
  - 🌎 `Sales`: Global and regional sales (NA, EU, JP, Other)

## Languages and Tools Used
- **SQL**: For database management and queries.
- **Tableau**: For creating interactive dashboards.
---

## 📌 Database Schema (3NF Normalization)
The dataset was transformed into a **relational database** with the following structure:

