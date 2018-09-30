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

ActiveRecord::Schema.define(version: 20180929214644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dmsessions", force: :cascade do |t|
    t.string   "titre"
    t.datetime "date_debut"
    t.datetime "date_fin"
    t.integer  "programme_id"
    t.integer  "responsable_id"
    t.integer  "medecin_referent_id"
    t.string   "description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.json     "documents"
    t.index ["medecin_referent_id"], name: "index_dmsessions_on_medecin_referent_id", using: :btree
    t.index ["programme_id"], name: "index_dmsessions_on_programme_id", using: :btree
    t.index ["responsable_id"], name: "index_dmsessions_on_responsable_id", using: :btree
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "programme_id"
    t.string   "fichier"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["programme_id"], name: "index_documents_on_programme_id", using: :btree
  end

  create_table "programmes", force: :cascade do |t|
    t.string   "titre"
    t.datetime "date_debut"
    t.datetime "date_fin"
    t.integer  "responsable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.json     "documents"
    t.index ["responsable_id"], name: "index_programmes_on_responsable_id", using: :btree
  end

  create_table "relation_dmsession_users", force: :cascade do |t|
    t.integer  "dmsession_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["dmsession_id"], name: "index_relation_dmsession_users_on_dmsession_id", using: :btree
    t.index ["user_id"], name: "index_relation_dmsession_users_on_user_id", using: :btree
  end

  create_table "relation_reunion_users", force: :cascade do |t|
    t.integer  "reunion_id"
    t.integer  "user_id"
    t.string   "user_role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reunion_id"], name: "index_relation_reunion_users_on_reunion_id", using: :btree
    t.index ["user_id"], name: "index_relation_reunion_users_on_user_id", using: :btree
  end

  create_table "reunions", force: :cascade do |t|
    t.string   "titre"
    t.datetime "date_debut"
    t.string   "lieu"
    t.string   "ordre_du_jour"
    t.integer  "dmsession_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.json     "documents"
    t.string   "historique"
    t.index ["dmsession_id"], name: "index_reunions_on_dmsession_id", using: :btree
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
    t.json     "documents"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["societe_id"], name: "index_users_on_societe_id", using: :btree
  end

  add_foreign_key "dmsessions", "programmes"
  add_foreign_key "documents", "programmes"
  add_foreign_key "relation_dmsession_users", "dmsessions"
  add_foreign_key "relation_dmsession_users", "users"
  add_foreign_key "relation_reunion_users", "reunions"
  add_foreign_key "relation_reunion_users", "users"
  add_foreign_key "reunions", "dmsessions"
  add_foreign_key "users", "societes"
end
