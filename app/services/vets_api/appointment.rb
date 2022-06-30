class VetsApi::Appointment < VetsApi 
  def create_appointment
    response = HTTParty.post("#{@api_url}/pets/#{@params[:pet_id]}/appointment" ,
    body: { vet_email: vet_email, date: @params[:date] }, 
    headers: @header)
  end

  private
  def vet_email
    response = HTTParty.get("#{@api_url}/vets", headers: @header)
    email = ''
    response.each do |vet|
      vet['pets'].each do |pet|
        pet['registrations'].each do |registration| 
          if registration['id'].to_s == @params[:registration_id]
            email = vet['email']
          end
        end
      end
    end 
    email 
  end
end