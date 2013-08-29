json.array!(@notices) do |notice|
  json.extract! notice, :title, :content, :creator_id, :approval_id, :release_time, :expiration_time, :status
  json.url notice_url(notice, format: :json)
end
