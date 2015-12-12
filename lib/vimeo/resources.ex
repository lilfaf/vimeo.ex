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
    Defines album schema.
    """

    defstruct name:          nil,
              description:   nil,
              link:          nil,
              duration:      nil,
              pictures:      nil,
              user:          nil,
              created_time:  nil,
              modified_time: nil
  end

  defmodule Category do
    @moduledoc """
    Defines category schema.
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
    Defines channel schema.
    """

    defstruct uri:           nil,
              name:          nil,
              description:   nil,
              link:          nil,
              pictures:      nil,
              user:          nil,
              created_time:  nil,
              modified_time: nil
  end

  defmodule Group do
    @moduledoc """
    Defines group schema.
    """

    defstruct uri:           nil,
              name:          nil,
              description:   nil,
              link:          nil,
              privacy:       nil,
              pictures:      nil,
              user:          nil,
              created_time:  nil,
              modified_time: nil
  end

  defmodule Picture do
    @moduledoc """
    Defines Picture schema
    """

    defstruct uri:    nil,
              active: nil,
              type:   nil,
              sizes:  nil
  end

  defmodule Tag do
    @moduledoc """
    Defines Tag schema
    """

    defstruct uri:       nil,
              name:      nil,
              tag:       nil,
              canonical: nil
  end

  defmodule Video do
    @moduledoc """
    Defines Video schema.
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
              user:          nil,
              created_time:  nil,
              modified_time: nil
  end

  defmodule Credit do
    @moduledoc """
    Defines Credit schema
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
    Defines Comment schema
    """

    defstruct uri:  nil,
              type: nil,
              text: nil,
              user: nil
  end
end
