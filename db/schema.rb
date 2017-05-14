# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170514151951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "programmes", force: :cascade do |t|
    t.string   "titre"
    t.datetime "date_debut"
    t.datetime "date_fin"
    t.integer  "responsable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["responsable_id"], name: "index_programmes_on_responsable_id", using: :btree
  end

  create_table "societes", force: :cascade do |t|
    t.string   "raison_sociale"
    t.string   "adresse"
    t.string   "code_postal"
    t.string   "ville"
    t.string   "telephone"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "nom"
    t.string   "email"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              default: false
    t.string   "prenom"
    t.string   "civilite"
    t.string   "profil"
    t.integer  "societe_id"
    t.string   "adresse"
    t.string   "code_postal"
    t.string   "ville"
    t.string   "telephone"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["societe_id"], name: "index_users_on_societe_id", using: :btree
  end

  add_foreign_key "users", "societes"
end
