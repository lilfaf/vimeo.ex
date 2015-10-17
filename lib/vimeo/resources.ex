defmodule Vimeo.Resources do
  @moduledoc false

  defmodule User do
    @moduledoc """
    Defines a user schema.
    """

    defstruct uri:      nil,
              name:     nil,
              link:     nil,
              location: nil,
              bio:      nil,
              account:  nil,
              pictures: nil,
              websites: nil,
              stats:    nil
  end

  defmodule Album do
    @moduledoc """
    Defines a album schema.
    """

    defstruct name:          nil,
              description:   nil,
              link:          nil,
              duration:      nil,
              pictures:      nil,
              created_time:  nil,
              modified_time: nil
  end

  defmodule Category do
    @moduledoc """
    Defines a category schema.
    """

    defstruct uri:           nil,
              name:          nil,
              link:          nil,
              parent:        nil,
              pictures:      nil,
              subcategories: nil
  end

  defmodule Channel do
    @moduledoc """
    Defines a channel schema.
    """

    defstruct uri:           nil,
              name:          nil,
              description:   nil,
              link:          nil,
              pictures:      nil,
              created_time:  nil,
              modified_time: nil
  end

  defmodule Group do
    @moduledoc """
    Defines a group schema.
    """

    defstruct uri:           nil,
              name:          nil,
              description:   nil,
              link:          nil,
              privacy:       nil,
              pictures:      nil,
              created_time:  nil,
              modified_time: nil
  end

  defmodule Picture do
    @moduledoc """
    Defines a Picture schema
    """

    defstruct uri:    nil,
              active: nil,
              type:   nil,
              sizes:  nil
  end

  defmodule Tag do
    @moduledoc """
    Defines a Tag schema
    """

  defstruct uri:       nil,
            name:      nil,
            tag:       nil,
            canonical: nil
  end

  defmodule Video do
    @moduledoc """
    Defines a Video schema.
    """

    defstruct uri:           nil,
              name:          nil,
              description:   nil,
              link:          nil,
              duration:      nil,
              width:         nil,
              height:        nil,
              language:      nil,
              licence:       nil,
              embed:         nil,
              pictures:      nil,
              tags:          nil,
              created_time:  nil,
              modified_time: nil
  end

  defmodule Credit do
    @moduledoc """
    Defines a Credit schema
    """

    defstruct uri:   nil,
              video: nil,
              tags:  nil,
              user:  nil,
              role:  nil,
              name:  nil
  end

  defmodule Comment do
    @moduledoc """
    Defines a Comment schema
    """

    defstruct uri:  nil,
              type: nil,
              text: nil,
              user: nil
  end
end