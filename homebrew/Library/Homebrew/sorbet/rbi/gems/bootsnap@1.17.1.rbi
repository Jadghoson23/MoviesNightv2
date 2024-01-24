# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `bootsnap` gem.
# Please instead update this file by running `bin/tapioca gem bootsnap`.

# source://bootsnap//lib/bootsnap/version.rb#3
module Bootsnap
  extend ::Bootsnap

  # @return [Boolean]
  #
  # source://bootsnap//lib/bootsnap/bundler.rb#6
  def bundler?; end

  class << self
    # source://bootsnap//lib/bootsnap.rb#34
    def _instrument(event, path); end

    # source://bootsnap//lib/bootsnap.rb#122
    def absolute_path?(path); end

    # source://bootsnap//lib/bootsnap.rb#70
    def default_setup; end

    # source://bootsnap//lib/bootsnap.rb#27
    def instrumentation=(callback); end

    # source://bootsnap//lib/bootsnap.rb#14
    def log!; end

    # Returns the value of attribute logger.
    #
    # source://bootsnap//lib/bootsnap.rb#12
    def logger; end

    # source://bootsnap//lib/bootsnap.rb#18
    def logger=(logger); end

    # Allow the C extension to redefine `rb_get_path` without warning.
    # Allow the C extension to redefine `rb_get_path` without warning.
    #
    # source://bootsnap//lib/bootsnap.rb#130
    def rb_get_path(fname); end

    # source://bootsnap//lib/bootsnap.rb#38
    def setup(cache_dir:, development_mode: T.unsafe(nil), load_path_cache: T.unsafe(nil), ignore_directories: T.unsafe(nil), readonly: T.unsafe(nil), compile_cache_iseq: T.unsafe(nil), compile_cache_yaml: T.unsafe(nil), compile_cache_json: T.unsafe(nil)); end

    # source://bootsnap//lib/bootsnap.rb#66
    def unload_cache!; end
  end
end

# source://bootsnap//lib/bootsnap/compile_cache.rb#4
module Bootsnap::CompileCache
  class << self
    # source://bootsnap//lib/bootsnap/compile_cache.rb#12
    def setup(cache_dir:, iseq:, yaml:, json:, readonly: T.unsafe(nil)); end

    # @return [Boolean]
    #
    # source://bootsnap//lib/bootsnap/compile_cache.rb#45
    def supported?; end
  end
end

# source://bootsnap//lib/bootsnap/compile_cache.rb#10
class Bootsnap::CompileCache::Error < ::StandardError; end

# source://bootsnap//lib/bootsnap/compile_cache.rb#5
Bootsnap::CompileCache::UNCOMPILABLE = T.let(T.unsafe(nil), BasicObject)

# source://bootsnap//lib/bootsnap/explicit_require.rb#4
module Bootsnap::ExplicitRequire
  class << self
    # source://bootsnap//lib/bootsnap/explicit_require.rb#17
    def from_archdir(feature); end

    # source://bootsnap//lib/bootsnap/explicit_require.rb#13
    def from_rubylibdir(feature); end

    # source://bootsnap//lib/bootsnap/explicit_require.rb#9
    def from_self(feature); end

    # Given a set of gems, run a block with the LOAD_PATH narrowed to include
    # only core ruby source paths and these gems -- that is, roughly,
    # temporarily remove all gems not listed in this call from the LOAD_PATH.
    #
    # This is useful before bootsnap is fully-initialized to load gems that it
    # depends on, without forcing full LOAD_PATH traversals.
    #
    # source://bootsnap//lib/bootsnap/explicit_require.rb#27
    def with_gems(*gems); end
  end
end

# source://bootsnap//lib/bootsnap/explicit_require.rb#5
Bootsnap::ExplicitRequire::ARCHDIR = T.let(T.unsafe(nil), String)

# source://bootsnap//lib/bootsnap/explicit_require.rb#7
Bootsnap::ExplicitRequire::DLEXT = T.let(T.unsafe(nil), String)

# source://bootsnap//lib/bootsnap/explicit_require.rb#6
Bootsnap::ExplicitRequire::RUBYLIBDIR = T.let(T.unsafe(nil), String)

# source://bootsnap//lib/bootsnap.rb#9
class Bootsnap::InvalidConfiguration < ::StandardError; end

# source://bootsnap//lib/bootsnap/load_path_cache.rb#4
module Bootsnap::LoadPathCache
  class << self
    # Returns the value of attribute enabled.
    #
    # source://bootsnap//lib/bootsnap/load_path_cache.rb#27
    def enabled?; end

    # Returns the value of attribute load_path_cache.
    #
    # source://bootsnap//lib/bootsnap/load_path_cache.rb#27
    def load_path_cache; end

    # Returns the value of attribute loaded_features_index.
    #
    # source://bootsnap//lib/bootsnap/load_path_cache.rb#27
    def loaded_features_index; end

    # source://bootsnap//lib/bootsnap/load_path_cache.rb#31
    def setup(cache_path:, development_mode:, ignore_directories:, readonly: T.unsafe(nil)); end

    # @return [Boolean]
    #
    # source://bootsnap//lib/bootsnap/load_path_cache.rb#56
    def supported?; end

    # source://bootsnap//lib/bootsnap/load_path_cache.rb#48
    def unload!; end
  end
end

# source://bootsnap//lib/bootsnap/load_path_cache.rb#22
Bootsnap::LoadPathCache::CACHED_EXTENSIONS = T.let(T.unsafe(nil), Array)

# source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#7
class Bootsnap::LoadPathCache::Cache
  # @return [Cache] a new instance of Cache
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#10
  def initialize(store, path_obj, development_mode: T.unsafe(nil)); end

  # Try to resolve this feature to an absolute path without traversing the
  # loadpath.
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#56
  def find(feature); end

  # What is the path item that contains the dir as child?
  # e.g. given "/a/b/c/d" exists, and the path is ["/a/b"], load_dir("c/d")
  # is "/a/b".
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#22
  def load_dir(dir); end

  # source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#116
  def push_paths(sender, *paths); end

  # source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#122
  def reinitialize(path_obj = T.unsafe(nil)); end

  # source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#110
  def unshift_paths(sender, *paths); end

  private

  # @return [Boolean]
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#135
  def dir_changed?; end

  # source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#180
  def expand_path(feature); end

  # source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#211
  def maybe_append_extension(feature); end

  # source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#188
  def now; end

  # source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#145
  def push_paths_locked(*paths); end

  # source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#207
  def search_index(feature); end

  # @return [Boolean]
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#184
  def stale?; end

  # source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#239
  def try_ext(feature); end

  # source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#219
  def try_index(feature); end

  # source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#163
  def unshift_paths_locked(*paths); end
end

# seconds
#
# source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#8
Bootsnap::LoadPathCache::Cache::AGE_THRESHOLD = T.let(T.unsafe(nil), Integer)

# { 'enumerator' => nil, 'enumerator.so' => nil, ... }
#
# source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#32
Bootsnap::LoadPathCache::Cache::BUILTIN_FEATURES = T.let(T.unsafe(nil), Hash)

# source://bootsnap//lib/bootsnap/load_path_cache/cache.rb#27
Bootsnap::LoadPathCache::Cache::TRUFFLERUBY_LIB_DIR_PREFIX = T.let(T.unsafe(nil), T.untyped)

# source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#5
module Bootsnap::LoadPathCache::ChangeObserver
  class << self
    # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#65
    def register(arr, observer); end

    # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#74
    def unregister(arr); end
  end
end

# source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#6
module Bootsnap::LoadPathCache::ChangeObserver::ArrayMixin
  # For each method that adds items to one end or another of the array
  # (<<, push, unshift, concat), override that method to also notify the
  # observer of the change.
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#10
  def <<(entry); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def []=(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#15
  def append(*entries); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def clear(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#58
  def clone; end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def collect!(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def compact!(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#27
  def concat(entries); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def delete(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def delete_at(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def delete_if(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#58
  def dup; end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def fill(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def flatten!(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def insert(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def keep_if(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def map!(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def pop(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#21
  def prepend(*entries); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#15
  def push(*entries); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def reject!(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def replace(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def reverse!(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def rotate!(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def select!(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def shift(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def shuffle!(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def slice!(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def sort!(*args, &block); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#51
  def sort_by!(*args, &block); end

  # uniq! keeps the first occurrence of each path, otherwise preserving
  # order, preserving the effective load path
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#34
  def uniq!(*args); end

  # source://bootsnap//lib/bootsnap/load_path_cache/change_observer.rb#21
  def unshift(*entries); end
end

# source://bootsnap//lib/bootsnap/load_path_cache.rb#16
Bootsnap::LoadPathCache::DLEXT = T.let(T.unsafe(nil), String)

# This is nil on linux and darwin, but I think it's '.o' on some other
# platform.  I'm not really sure which, but it seems better to replicate
# ruby's semantics as faithfully as possible.
#
# source://bootsnap//lib/bootsnap/load_path_cache.rb#20
Bootsnap::LoadPathCache::DLEXT2 = T.let(T.unsafe(nil), T.untyped)

# source://bootsnap//lib/bootsnap/load_path_cache.rb#11
Bootsnap::LoadPathCache::DL_EXTENSIONS = T.let(T.unsafe(nil), Array)

# source://bootsnap//lib/bootsnap/load_path_cache.rb#7
Bootsnap::LoadPathCache::DOT_RB = T.let(T.unsafe(nil), String)

# source://bootsnap//lib/bootsnap/load_path_cache.rb#8
Bootsnap::LoadPathCache::DOT_SO = T.let(T.unsafe(nil), String)

# source://bootsnap//lib/bootsnap/load_path_cache.rb#5
Bootsnap::LoadPathCache::FALLBACK_SCAN = T.let(T.unsafe(nil), BasicObject)

# LoadedFeaturesIndex partially mirrors an internal structure in ruby that
# we can't easily obtain an interface to.
#
# This works around an issue where, without bootsnap, *ruby* knows that it
# has already required a file by its short name (e.g. require 'bundler') if
# a new instance of bundler is added to the $LOAD_PATH which resolves to a
# different absolute path. This class makes bootsnap smart enough to
# realize that it has already loaded 'bundler', and not just
# '/path/to/bundler'.
#
# If you disable LoadedFeaturesIndex, you can see the problem this solves by:
#
# 1. `require 'a'`
# 2. Prepend a new $LOAD_PATH element containing an `a.rb`
# 3. `require 'a'`
#
# Ruby returns false from step 3.
# With bootsnap but with no LoadedFeaturesIndex, this loads two different
#   `a.rb`s.
# With bootsnap and with LoadedFeaturesIndex, this skips the second load,
#   returning false like ruby.
#
# source://bootsnap//lib/bootsnap/load_path_cache/loaded_features_index.rb#26
class Bootsnap::LoadPathCache::LoadedFeaturesIndex
  # @return [LoadedFeaturesIndex] a new instance of LoadedFeaturesIndex
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/loaded_features_index.rb#27
  def initialize; end

  # source://bootsnap//lib/bootsnap/load_path_cache/loaded_features_index.rb#72
  def cursor(short); end

  # source://bootsnap//lib/bootsnap/load_path_cache/loaded_features_index.rb#78
  def identify(short, cursor); end

  # @return [Boolean]
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/loaded_features_index.rb#68
  def key?(feature); end

  # We've optimized for initialize and register to be fast, and purge to be tolerable.
  # If access patterns make this not-okay, we can lazy-invert the LFI on
  # first purge and work from there.
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/loaded_features_index.rb#54
  def purge(feature); end

  # source://bootsnap//lib/bootsnap/load_path_cache/loaded_features_index.rb#61
  def purge_multi(features); end

  # There is a relatively uncommon case where we could miss adding an
  # entry:
  #
  # If the user asked for e.g. `require 'bundler'`, and we went through the
  # `FALLBACK_SCAN` pathway in `kernel_require.rb` and therefore did not
  # pass `long` (the full expanded absolute path), then we did are not able
  # to confidently add the `bundler.rb` form to @lfi.
  #
  # We could either:
  #
  # 1. Just add `bundler.rb`, `bundler.so`, and so on, which is close but
  #    not quite right; or
  # 2. Inspect $LOADED_FEATURES upon return from yield to find the matching
  #    entry.
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/loaded_features_index.rb#105
  def register(short, long); end

  private

  # Might Ruby automatically search for this extension if
  # someone tries to 'require' the file without it? E.g. Ruby
  # will implicitly try 'x.rb' if you ask for 'x'.
  #
  # This is complex and platform-dependent, and the Ruby docs are a little
  # handwavy about what will be tried when and in what order.
  # So optimistically pretend that all known elidable extensions
  # will be tried on all platforms, and that people are unlikely
  # to name files in a way that assumes otherwise.
  # (E.g. It's unlikely that someone will know that their code
  # will _never_ run on MacOS, and therefore think they can get away
  # with calling a Ruby file 'x.dylib.rb' and then requiring it as 'x.dylib'.)
  #
  # See <https://ruby-doc.org/core-2.6.4/Kernel.html#method-i-require>.
  #
  # @return [Boolean]
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/loaded_features_index.rb#146
  def extension_elidable?(feature); end

  # source://bootsnap//lib/bootsnap/load_path_cache/loaded_features_index.rb#150
  def strip_extension_if_elidable(feature); end
end

# source://bootsnap//lib/bootsnap/load_path_cache/loaded_features_index.rb#129
Bootsnap::LoadPathCache::LoadedFeaturesIndex::STRIP_EXTENSION = T.let(T.unsafe(nil), Regexp)

# source://bootsnap//lib/bootsnap/load_path_cache/path.rb#7
class Bootsnap::LoadPathCache::Path
  # @return [Path] a new instance of Path
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/path.rb#24
  def initialize(path, real: T.unsafe(nil)); end

  # Return a list of all the requirable files and all of the subdirectories
  # of this +Path+.
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/path.rb#59
  def entries_and_dirs(store); end

  # source://bootsnap//lib/bootsnap/load_path_cache/path.rb#82
  def expanded_path; end

  # True if the path exists, but represents a non-directory object
  #
  # @return [Boolean]
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/path.rb#47
  def non_directory?; end

  # Returns the value of attribute path.
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/path.rb#22
  def path; end

  # @return [Boolean]
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/path.rb#53
  def relative?; end

  # A path is considered 'stable' if it is part of a Gem.path or the ruby
  # distribution. When adding or removing files in these paths, the cache
  # must be cleared before the change will be noticed.
  #
  # @return [Boolean]
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/path.rb#11
  def stable?; end

  # source://bootsnap//lib/bootsnap/load_path_cache/path.rb#29
  def to_realpath; end

  # A path is considered volatile if it doesn't live under a Gem.path or
  # the ruby distribution root. These paths are scanned for new additions
  # more frequently.
  #
  # @return [Boolean]
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/path.rb#18
  def volatile?; end

  private

  # last time a directory was modified in this subtree. +dirs+ should be a
  # list of relative paths to directories under +path+. e.g. for /a/b and
  # /a/b/c, pass ('/a/b', ['c'])
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/path.rb#99
  def latest_mtime(path, dirs); end

  # (expensive) returns [entries, dirs]
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/path.rb#92
  def scan!; end

  # source://bootsnap//lib/bootsnap/load_path_cache/path.rb#123
  def stability; end
end

# Built-in ruby lib stuff doesn't change, but things can occasionally be
# installed into sitedir, which generally lives under rubylibdir.
#
# source://bootsnap//lib/bootsnap/load_path_cache/path.rb#120
Bootsnap::LoadPathCache::Path::RUBY_LIBDIR = T.let(T.unsafe(nil), String)

# source://bootsnap//lib/bootsnap/load_path_cache/path.rb#121
Bootsnap::LoadPathCache::Path::RUBY_SITEDIR = T.let(T.unsafe(nil), String)

# a Path can be either stable of volatile, depending on how frequently we
# expect its contents may change. Stable paths aren't rescanned nearly as
# often.
#
# source://bootsnap//lib/bootsnap/load_path_cache/path.rb#115
Bootsnap::LoadPathCache::Path::STABLE = T.let(T.unsafe(nil), Symbol)

# source://bootsnap//lib/bootsnap/load_path_cache/path.rb#116
Bootsnap::LoadPathCache::Path::VOLATILE = T.let(T.unsafe(nil), Symbol)

# source://bootsnap//lib/bootsnap/load_path_cache/path_scanner.rb#7
module Bootsnap::LoadPathCache::PathScanner
  class << self
    # source://bootsnap//lib/bootsnap/load_path_cache/path_scanner.rb#23
    def call(path); end

    # Returns the value of attribute ignored_directories.
    #
    # source://bootsnap//lib/bootsnap/load_path_cache/path_scanner.rb#21
    def ignored_directories; end

    # Sets the attribute ignored_directories
    #
    # @param value the value to set the attribute ignored_directories to.
    #
    # source://bootsnap//lib/bootsnap/load_path_cache/path_scanner.rb#21
    def ignored_directories=(_arg0); end

    # source://bootsnap//lib/bootsnap/load_path_cache/path_scanner.rb#69
    def os_path(path); end

    # source://bootsnap//lib/bootsnap/load_path_cache/path_scanner.rb#49
    def walk(absolute_dir_path, relative_dir_path, &block); end
  end
end

# source://bootsnap//lib/bootsnap/load_path_cache/path_scanner.rb#10
Bootsnap::LoadPathCache::PathScanner::ALTERNATIVE_NATIVE_EXTENSIONS_PATTERN = T.let(T.unsafe(nil), Regexp)

# source://bootsnap//lib/bootsnap/load_path_cache/path_scanner.rb#12
Bootsnap::LoadPathCache::PathScanner::BUNDLE_PATH = T.let(T.unsafe(nil), String)

# source://bootsnap//lib/bootsnap/load_path_cache/path_scanner.rb#9
Bootsnap::LoadPathCache::PathScanner::NORMALIZE_NATIVE_EXTENSIONS = T.let(T.unsafe(nil), TrueClass)

# source://bootsnap//lib/bootsnap/load_path_cache/path_scanner.rb#8
Bootsnap::LoadPathCache::PathScanner::REQUIRABLE_EXTENSIONS = T.let(T.unsafe(nil), Array)

# source://bootsnap//lib/bootsnap/load_path_cache.rb#9
Bootsnap::LoadPathCache::SLASH = T.let(T.unsafe(nil), String)

# source://bootsnap//lib/bootsnap/load_path_cache/store.rb#9
class Bootsnap::LoadPathCache::Store
  # @return [Store] a new instance of Store
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/store.rb#16
  def initialize(store_path, readonly: T.unsafe(nil)); end

  # @raise [SetOutsideTransactionNotAllowed]
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/store.rb#28
  def fetch(key); end

  # source://bootsnap//lib/bootsnap/load_path_cache/store.rb#24
  def get(key); end

  # @raise [SetOutsideTransactionNotAllowed]
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/store.rb#40
  def set(key, value); end

  # @raise [NestedTransactionError]
  #
  # source://bootsnap//lib/bootsnap/load_path_cache/store.rb#49
  def transaction; end

  private

  # source://bootsnap//lib/bootsnap/load_path_cache/store.rb#66
  def commit_transaction; end

  # source://bootsnap//lib/bootsnap/load_path_cache/store.rb#112
  def default_data; end

  # source://bootsnap//lib/bootsnap/load_path_cache/store.rb#95
  def dump_data; end

  # source://bootsnap//lib/bootsnap/load_path_cache/store.rb#73
  def load_data; end

  # source://bootsnap//lib/bootsnap/load_path_cache/store.rb#61
  def mark_for_mutation!; end

  # source://bootsnap//lib/bootsnap/load_path_cache/store.rb#116
  def mkdir_p(path); end
end

# source://bootsnap//lib/bootsnap/load_path_cache/store.rb#11
Bootsnap::LoadPathCache::Store::CURRENT_VERSION = T.let(T.unsafe(nil), String)

# source://bootsnap//lib/bootsnap/load_path_cache/store.rb#13
class Bootsnap::LoadPathCache::Store::NestedTransactionError < ::StandardError; end

# source://bootsnap//lib/bootsnap/load_path_cache/store.rb#14
class Bootsnap::LoadPathCache::Store::SetOutsideTransactionNotAllowed < ::StandardError; end

# source://bootsnap//lib/bootsnap/load_path_cache/store.rb#10
Bootsnap::LoadPathCache::Store::VERSION_KEY = T.let(T.unsafe(nil), String)

# source://bootsnap//lib/bootsnap/version.rb#4
Bootsnap::VERSION = T.let(T.unsafe(nil), String)
