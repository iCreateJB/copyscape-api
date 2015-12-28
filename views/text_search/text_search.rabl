object @search

node(:code){ @search.code }
node(:total_count){ @search.count }

if @search.respond_to?(:message)
  node(:message){ @search.message }
end

child @search.entries => :entries  do
  extends 'text_search/entries'
end
