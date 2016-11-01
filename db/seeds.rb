User.create(
  email: 'admin@qq.com',
  password: '123123123'
  )

20.times do |i|
  User.create(
      email: "#{SecureRandom.hex(4)}@qq.com",
      password: '123123123'
    )
end


50.times do |i|
  App.create!(
    name: "#{i}",
    remark: SecureRandom.hex(9)
    )

  puts ">>>>>>>>>>>>>>>>>>>>>>>>>created......#{i}"
end