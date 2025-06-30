puts "\n== Creating admin account =="

default_password = '12345678'

admin = User.find_or_create_by!(email: 'master@email.com') do |user|
  user.first_name = 'Master'
  user.last_name  = 'Admin'
  user.username   = 'Master'
  user.password   = default_password
  user.password_confirmation = default_password
  user.role       = :admin
  user.biography  = 'This account has the privileges of an Admin'
  user.birth_date = 30.years.ago
  user.gender     = :male
  user.location   = 'Toronto, Canada'
end.tap do |user|
  avatar_path = Rails.root.join("app/assets/images/master_avatar.png")
  user.avatar.attach(
    io: File.open(avatar_path),
    filename: "master_avatar.png",
    content_type: "image/png"
  ) unless user.avatar.attached?
end

puts "\n== Creating regular user =="

user = User.find_or_create_by!(email: 'user1@email.com') do |u|
  u.first_name = 'Alice'
  u.last_name  = 'Smith'
  u.username   = 'User_1'
  u.password   = default_password
  u.password_confirmation = default_password
  u.role       = :regular
  u.biography  = 'Just a regular user exploring the platform!'
  u.birth_date = 25.years.ago
  u.gender     = :female
  u.location   = 'São Paulo, Brazil'
end.tap do |u|
  avatar_path = Rails.root.join("app/assets/images/default_avatar.png")
  u.avatar.attach(
    io: File.open(avatar_path),
    filename: "default_avatar.png",
    content_type: "image/png"
  ) unless u.avatar.attached?
end

puts "\n== Creating tags =="

['Tag One', 'Tag Two', 'Tag Three', 'Tag Four'].each do |name|
  Tag.find_or_create_by!(name: name)
end

puts "\n== Creating announcements =="

Announcement.find_or_create_by!(title: 'Announcement 1') do |a|
  a.body     = 'Description test'
  a.start_at = 1.day.ago
  a.end_at   = 5.days.from_now
end

Announcement.find_or_create_by!(title: 'Announcement 2') do |a|
  a.body     = 'Description test'
  a.start_at = 1.day.ago
  a.end_at   = 5.months.from_now
end

puts "\n== Creating example contents =="

tags = Tag.all.to_a
visibilities = %w[visible_to_all only_me unlisted]

default_cover_path = Rails.root.join("app/assets/images/sample_cover.jpg")

[
  { user: admin, title: "Admin’s Guide to the Platform" },
  { user: user, title: "My First Post on the Platform" },
  { user: user, title: "Thoughts on Ruby on Rails" },
  { user: user, title: "Designing a Better Web App" }
].each do |data|
  content = Content.find_or_create_by!(title: data[:title], user: data[:user]) do |c|
    c.body       = <<~HTML
                    <h1>Bem-vindo ao Mundo do Rails!</h1>
                    <p>Este é um <strong>exemplo de conteúdo</strong> gerado via <em>seeds</em> para demonstrar as capacidades do <strong>Action Text</strong>. Você notará que podemos incluir diferentes elementos HTML para enriquecer a experiência de leitura.</p>

                    <p>No Rails, a criação de aplicações web robustas é facilitada por seus princípios e convenções. Com o Action Text, adicionar um editor de texto rico aos seus modelos se tornou incrivelmente simples, permitindo que usuários criem e editem conteúdo com formatação avançada.</p>

                    <h2>Recursos Impressionantes:</h2>
                    <ul>
                      <li>Edição de texto rica e intuitiva.</li>
                      <li>Upload e incorporação de imagens e outros anexos.</li>
                      <li>Integração perfeita com o Active Storage.</li>
                      <li>Experiência de usuário aprimorada para criação de conteúdo.</li>
                    </ul>

                    <p>Explore as possibilidades e liberte sua criatividade!</p>
                  HTML
    c.visibility = visibilities.sample
    c.tag_ids    = tags.sample(rand(1..3)).map(&:id)
  end

  unless content.cover.attached?
    content.cover.attach(
      io: File.open(default_cover_path),
      filename: "sample_cover.jpg",
      content_type: "image/jpeg"
    )
  end
end
