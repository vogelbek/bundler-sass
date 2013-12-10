desc "Look at all Sass partials in a folder and build a manifest"
task :build_manifest do
  include SassSort
  include SassCreator
  ENV['filename'] ||= "manifest.sass"
  import_array = SassSort.import_order
  manifest_hash = {ENV['filename'] => import_array}
  manifest = SassCreator::SassFile.new manifest_hash
  manifest.build_imports
end