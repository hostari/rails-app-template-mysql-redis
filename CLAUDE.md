# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Rails 8.0.2 application configured with MySQL database and Redis for caching. The project uses modern Rails features including Solid Cache, Solid Queue, and Solid Cable.

## Development Commands

### Database Operations
- `rails db:create` - Create databases
- `rails db:migrate` - Run migrations
- `rails db:seed` - Run database seeds
- `rails db:reset` - Drop, create, migrate, and seed database
- `rails db:rollback` - Rollback last migration

### Testing
- `rails test` - Run all tests
- `rails test test/models/` - Run model tests
- `rails test test/controllers/` - Run controller tests
- `rails test test/integration/` - Run integration tests
- `rails test test/system/` - Run system tests
- `rails test:system` - Run system tests (alternative syntax)

### Development Server
- `rails server` or `rails s` - Start development server
- `rails console` or `rails c` - Start Rails console

### Code Quality
- `bundle exec rubocop` - Run RuboCop linter (uses omakase configuration)
- `bundle exec brakeman` - Run security analysis

### Asset Management
- Assets are managed by Propshaft (modern asset pipeline)
- JavaScript uses import maps (`importmap-rails`)
- Stimulus controllers are in `app/javascript/controllers/`

## Architecture

### Database Configuration
- **Primary**: MySQL with utf8mb4 encoding
- **Development/Test**: Local MySQL connection (root user, no password by default)
- **Production**: Multi-database setup with separate databases for:
  - Primary application data
  - Cache (Solid Cache)
  - Queue (Solid Queue) 
  - Cable (Solid Cable)

### Key Technologies
- **Rails 8.0.2**: Latest Rails with modern defaults
- **MySQL**: Primary database with mysql2 adapter
- **Redis**: Used for caching and background jobs
- **Solid Suite**: Modern Rails infrastructure gems
  - Solid Cache: Database-backed caching
  - Solid Queue: Database-backed job queue
  - Solid Cable: Database-backed ActionCable
- **Hotwire**: Turbo + Stimulus for modern frontend interactions
- **Kamal**: Deployment via Docker containers
- **Thruster**: HTTP caching/compression for Puma

### File Structure
- `app/javascript/`: Stimulus controllers and JavaScript modules
- `config/environments/`: Environment-specific configuration
- `test/`: Test suite using Rails minitest
- `lib/tasks/`: Custom Rake tasks
- `db/`: Database schemas for different adapters (cache, queue, cable)

## Environment Setup

The project uses `mise` for tool version management. Node.js is configured to use the latest version.

### Required Services
- MySQL server (for database)
- Redis server (for caching and jobs)

### Environment Variables
- `DB_HOST`: MySQL host (defaults to 127.0.0.1)
- `RAILS_MAX_THREADS`: Database connection pool size (defaults to 5)
- `RAILS_APP_TEMPLATE_MYSQL_REDIS_DATABASE_PASSWORD`: Production database password