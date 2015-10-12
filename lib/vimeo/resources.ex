defmodule Vimeo.Resources do
  @moduledoc false

  defmodule User do
    @moduledoc """
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

  defmodule Video do
    @moduledoc """
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
              created_time:  nil,
              modified_time: nil
  end
end