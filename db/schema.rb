# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130410053347) do

  create_table "charge_types", :force => true do |t|
    t.string   "name"
    t.boolean  "requires_booth_chair_approval"
    t.decimal  "default_amount",                :precision => 8, :scale => 2
    t.text     "description"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
  end

  create_table "charges", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "charge_type_id"
    t.decimal  "amount",                   :precision => 8, :scale => 2
    t.text     "description"
    t.integer  "issuing_participant_id"
    t.integer  "receiving_participant_id"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
    t.datetime "charged_at"
  end

  add_index "charges", ["organization_id"], :name => "index_charges_on_organization_id"

  create_table "checkouts", :force => true do |t|
    t.integer  "tool_id"
    t.datetime "checked_out_at"
    t.datetime "checked_in_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "participant_id"
    t.integer  "organization_id"
  end

  add_index "checkouts", ["tool_id"], :name => "index_checkouts_on_tool_id"

  create_table "memberships", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "participant_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.boolean  "is_booth_chair"
    t.string   "title"
    t.integer  "booth_chair_order"
  end

  add_index "memberships", ["organization_id"], :name => "index_memberships_on_organization_id"
  add_index "memberships", ["participant_id"], :name => "index_memberships_on_participant_id"

  create_table "organization_aliases", :force => true do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "organization_aliases", ["name"], :name => "index_organization_aliases_on_alias"
  add_index "organization_aliases", ["organization_id"], :name => "index_organization_aliases_on_organization_id"

  create_table "organization_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.integer  "organization_category_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "organizations", ["organization_category_id"], :name => "index_organizations_on_organization_category_id"

  create_table "participants", :force => true do |t|
    t.string   "andrewid"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.boolean  "has_signed_waiver"
    t.string   "phone_number"
    t.boolean  "has_signed_hardhat_waiver"
  end

  create_table "shift_participants", :force => true do |t|
    t.integer  "shift_id"
    t.integer  "participant_id"
    t.datetime "clocked_in_at"
    t.datetime "clocked_out_at"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "shift_participants", ["participant_id"], :name => "index_shift_participants_on_participant_id"
  add_index "shift_participants", ["shift_id"], :name => "index_shift_participants_on_shift_id"

  create_table "shift_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shifts", :force => true do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "required_number_of_participants"
    t.integer  "organization_id"
    t.integer  "shift_type_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "shifts", ["organization_id"], :name => "index_shifts_on_organization_id"

  create_table "task_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tasks", :force => true do |t|
    t.datetime "due_at"
    t.datetime "display_duration"
    t.integer  "completed_by_id"
    t.string   "name"
    t.text     "description"
    t.integer  "task_status_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "tasks", ["task_status_id"], :name => "index_tasks_on_task_status_id"

  create_table "tools", :force => true do |t|
    t.string   "name",        :null => false
    t.integer  "barcode"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tools", ["barcode"], :name => "index_tools_on_barcode"

end
