User.create(
  id: 1,
  email: 'admin@qq.com',
  password: '123123123'
  )

20.times do |i|
  User.create(
      email: "user_#{i}@qq.com",
      password: '123123123'
    )
end

