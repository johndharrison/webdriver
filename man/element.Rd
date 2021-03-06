% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/element.R
\name{element}
\alias{element}
\title{HTML element}
\description{
HTML element
}
\section{Usage}{

\preformatted{e <- s$find_element(css = NULL, link_text = NULL,
    partial_link_text = NULL, xpath = NULL)

e$find_element(css = NULL, link_text = NULL,
    partial_link_text = NULL, xpath = NULL)
e$find_elements(css = NULL, link_text = NULL,
    partial_link_text = NULL, xpath = NULL)

e$is_selected()
e$get_value()
e$set_value(value)
e$get_attribute(name)
e$get_class()
e$get_css_value(name)
e$get_text()
e$get_name()
e$get_data(name)
e$get_rect()
e$is_enabled()
e$click()
e$clear()
e$send_keys(...)
e$move_mouse_to(xoffset = NULL, yoffset = NULL)

e$execute_script(script, ...)
e$execute_script_async(script, ...)
}
}

\section{Arguments}{

\describe{
  \item{e}{An \code{element} object.}
  \item{s}{A \code{\link{session}} object.}
  \item{css}{Css selector to find an HTML element.}
  \item{link_text}{Find \code{<a>} HTML elements based on their
    \code{innerText}.}
  \item{partial_link_text}{Find \code{<a>} HTML elements based on their
    \code{innerText}. It uses partial matching.}
  \item{xpath}{Find HTML elements using XPath expressions.}
  \item{name}{String scalar, named of attribute, property or css key.
    For \code{get_data}, the key of the data attribute.}
  \item{xoffset}{Horizontal offset for mouse movement, relative to the
    position of the element. If at least of of \code{xoffset} and
    \code{yoffset} is \code{NULL}, then they are ignored.}
  \item{yoffset}{Vertical offset for mouse movement, relative to the
    position of the element. If at least of of \code{xoffset} and
    \code{yoffset} is \code{NULL}, then they are ignored.}
  \item{value}{Value to set, a character string.}
  \item{...}{For \code{send_keys} the keys to send, see
    \code{\link{key}}. For \code{execute_script} and
    \code{execute_script_async} argument to supply to the script.}
}
}

\section{Details}{


To create \code{element} objects, you need to use the \code{find_element}
(or \code{find_element}) method of a \code{\link{session}} object.

\code{e$find_element()} finds the \emph{next} HTML element from the
current one. You need to specify one of the \code{css}, \code{link_text},
\code{partial_link_text} and \code{xpath} arguments. It returns a new
\code{element} object.

\code{e$find_elements()} finds all matching HTML elements starting from
the current element. You need to specify one of the \code{css},
\code{link_text}, \code{partial_link_text} and \code{xpath} arguments.
It returns a list of newly created \code{element} objects.

\code{e$is_selected()} returns \code{TRUE} is the element is currently
selected, and \code{FALSE} otherwise.

\code{e$get_value()} returns the value of an input element, it is a
shorthand for \code{e$get_attribute("value")}.

\code{e$set_value()} sets the value of an input element, it is
essentially equivalent to sending keys via \code{e$send_keys()}.

\code{e$get_attribute()} queries an arbitrary HTML attribute. It is
does not exist, \code{NULL} is returned.

\code{e$get_class()} uses \code{e$get_attribute} to parse the
\sQuote{class} attribute into a character vector.

\code{e$get_css_value()} queries a CSS property of an element.

\code{e$get_text()} returns the \code{innerText} on an element.

\code{e$get_name()} returns the tag name of an element.

\code{e$get_data()} is a shorthand for querying \code{data-*} attributes.

\code{e$get_rect()} returns the \sQuote{rectangle} of an element. It is
named list with components \code{x}, \code{y}, \code{height} and
\code{width}.

\code{e$is_enabled()} returns \code{TRUE} if the element is enabled,
\code{FALSE} otherwise.

\code{e$click()} scrolls the element into view, and clicks the
in-view centre point of it.

\code{e$clear()} scrolls the element into view, and then attempts to
clear its value, checkedness or text content.

\code{e$send_keys()} scrolls the form control element into view, and
sends the provided keys to it. See \code{\link{key}} for a list of
special keys that can be sent.

\code{e$move_mouse_to()} moves the mouse cursor to the element, with
the specified offsets. If one or both offsets are \code{NULL}, then
it places the cursor on the center of the element. If the element is
not on the screen, then is scrolls it into the screen first.

\code{e$execute_script()} and \code{e$execute_script_async()}
call the method of the same name on the \code{\link{session}} object.
The first argument of the script (\code{arguments[0]}) will always
hold the element object itself.
}

