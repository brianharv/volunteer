require "spec_helper"

describe Volunteer do
  describe '#name' do
    it 'returns the name of the volunteer' do
      test_volunteer = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      expect(test_volunteer.name).to eq 'Jane'
    end
  end

  describe '#project_id' do
    it 'returns the project_id of the volunteer' do
      test_volunteer = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      expect(test_volunteer.project_id).to eq 1
    end
  end

  describe '#==' do
    it 'checks for equality based on the name of a volunteer' do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer2 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      expect(volunteer1 == volunteer2).to eq true
    end
  end

  describe('.all') do
    it('is empty to start') do
      expect(Volunteer.all).to(eq([]))
    end
  end  

  describe('.all') do
    it('returns all volunteers') do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => 1, :id => nil})
      volunteer2.save
      expect(Volunteer.all).to eq [volunteer1, volunteer2]
    end
  end

  describe('#save') do
    it('adds a volunteer to the database')do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      expect(Volunteer.all).to(eq([volunteer1]))
    end
  end

  describe('.find') do
    it('returns a volunteer by id') do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => 1, :id => nil})
      volunteer2.save
      expect(Volunteer.find(volunteer1.id)).to(eq(volunteer1))
    end
  end

  describe('.clear') do
    it('clears volunteers table') do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => 1, :id => nil})
      volunteer2.save
      Volunteer.clear
      expect(Volunteer.all).to(eq([]))
    end
  end 
  
  describe('#delete') do
    it('deletes a single volunteer entry') do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => 1, :id => nil})
      volunteer2.save
      volunteer1.delete
      expect(Volunteer.all).to(eq([volunteer2]))
    end
  end 
  
  describe('#update') do
    it('updates a volunteer entry by name') do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => 1, :id => nil})
      volunteer2.save
      volunteer2.update("Joseph", 1)
      expect(volunteer2.name).to(eq("Joseph"))
    end
  end
  
  describe('#update') do
    it('updates a volunteer entry by name and project_id') do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => 1, :id => nil})
      volunteer2.save
      volunteer2.update("Joseph", 2)
      expect(volunteer2.project_id).to(eq(2))
    end
  end 

  describe('.find_by_project') do
    it('find volunteer(s) by corresponding project_id.') do
      new_project = Project.new({:title => "Cleanup", :id => nil})
      new_project.save
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => 1, :id => nil})
      volunteer2.save
      expect(Volunteer.find_by_project(1)).to(eq([volunteer1, volunteer2]))
end